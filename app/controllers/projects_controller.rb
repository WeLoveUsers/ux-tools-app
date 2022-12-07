class ProjectsController < ApplicationController

  before_action :authenticate_user!, except: [:respond, :response_saved]
  before_action :set_project, only: [:show, :edit, :update, :close, :open, :destroy]
  before_action :load_project_data, only: [:show]

  # GET /projects
  # GET /projects.json
  def index
    default = 'date_desc'
    whitelist = ['name_asc', 'name_desc', 'date_asc', 'date_desc']
    @order_by_possible_values = {
      'date_desc' => 'du plus récent au plus ancien',
      'date_asc'  => 'du plus ancien au plus récent',
      'divider'   => '',
      'name_asc'  => 'de A à Z',
      'name_desc'  => 'de Z à A'
    }
    @order_by_selected_value = default
    @projects = current_user.projects.order(created_at: :desc)
    if (params.has_key?(:order_by) && whitelist.include?(params[:order_by]))
      @order_by_selected_value = params[:order_by]
      cookies[:order_projects_by] = params[:order_by]
    else
      if cookies[:order_projects_by] && whitelist.include?(cookies[:order_projects_by])
        @order_by_selected_value = cookies[:order_projects_by]
      end
    end

    case @order_by_selected_value
    when "name_asc"
      @projects = current_user.projects.order(product_name: :asc)
    when "name_desc"
      @projects = current_user.projects.order(product_name: :desc)
    when "date_asc"
      @projects = current_user.projects.order(created_at: :asc)
    when "date_desc"
      @projects = current_user.projects.order(created_at: :desc)
    end

  end

  # GET /projects/1
  # GET /projects/1.csv
  def show
    @show_variability = false
    if cookies[:show_variability] && cookies[:show_variability].to_i > 0
      @show_variability = true
    end
    @ci_level = cookies[:ci_level] || '95%'
    @ci_level_hash_key = 'ci_' + @ci_level[0..1]
    @ci_level_hash_key = @ci_level_hash_key.to_sym

    @back_to_responses = session["back_to_responses"]
    session["back_to_responses"] = nil

    filename = "[Questionnaire UX] - " + @project.product_name + "-" + @project.project_code + " (" + @project.questionnaire_id + ") - #{Date.today}"
    respond_to do |format|
      format.html
      #format.csv { send_data @project.responses.to_csv, filename: filename + ".csv" }
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xlsx"' }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # GET /projects/1/close
  def close
    @project.is_closed = true
    @project.save
    respond_to do |format|
      format.html { redirect_back fallback_location: @project }
    end
  end

  # GET /projects/1/open
  def open
    message = nil
    @project.is_closed = false
    if @project.should_get_closed
      @project.end_date = nil
      message = "Le projet a bien été réouvert et la date de fin a été supprimée."
    end
    @project.save
    respond_to do |format|
      format.html { redirect_back fallback_location: @project, notice: message }
    end
  end

  # GET /r/1
  def respond
    @project = Project.find_by uri_token: params[:uri_token]

    #Updates project status if needed
    if @project.should_get_closed
      @project.is_closed = true
      @project.save
    end

    @showForm = false
    @form = ''
    @has_already_responded = has_already_responded(@project)

    if (params.has_key?(:step))
      case @project.questionnaire_id_clean
      when "attrakdiff"
        case params[:step]
        when "1"
          @showForm = true
          @form = @project.questionnaire_template + "_" + "step" + params[:step]
          @response = ResponseAttrakDiff.new
        else
        end
      when "attrakdiff_abrege"
        case params[:step]
        when "1"
          @showForm = true
          @form = @project.questionnaire_template + "_" + "step" + params[:step]
          @response = ResponseAttrakDiffAbridged.new
        else
        end
      when "system_usability_scale"
        case params[:step]
        when "1"
          @showForm = true
          @form = @project.questionnaire_template + "_" + "step" + params[:step]
          @response = ResponseSu.new
        else
        end
      when "deep"
        case params[:step]
        when "1"
          @showForm = true
          @form = @project.questionnaire_template + "_" + "step" + params[:step]
          @response = ResponseDeep.new
        else
        end
      when "umux"
        case params[:step]
        when "1"
          @showForm = true
          @form = @project.questionnaire_template + "_" + "step" + params[:step]
          @response = ResponseUmux.new
        else
        end
      when "umux_lite"
        case params[:step]
        when "1"
          @showForm = true
          @form = @project.questionnaire_template + "_" + "step" + params[:step]
          @response = ResponseUmuxLite.new
        else
        end
      end
    end
    render layout: "public_response"
  end

  # GET /r/success/fr
  # GET /r/success.json/fr
  def response_saved
    @locale = params[:locale]
    @locale = I18n.default_locale unless I18n.locale_available? @locale
    render layout: "public_response"
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if params["redirect_back"] === "true"
      redirect_back = true
    else
      redirect_back = false
    end

    respond_to do |format|
      if @project.update(project_params)
        if redirect_back
          format.html { redirect_back fallback_location: @project, notice: "La modification a bien été enregistrée." }
        else
          format.html { redirect_to @project, notice: 'La modification a bien été enregistrée.' }
        end
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy_fully!
    #@project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Le projet d'évaluation a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:questionnaire_id, :questionnaire_language, :product_type, :product_name, :project_code, :instructions, :end_date, :uri_token, :forbid_multiple_reponses, :ask_user_ideas, :ask_user_summary, :ask_user_age, :ask_user_gender, :ask_user_occupation, :ask_user_first_use_date, :ask_user_group, :ask_user_usage_frequency)
    end

end
