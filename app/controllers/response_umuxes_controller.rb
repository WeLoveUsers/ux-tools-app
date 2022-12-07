class ResponseUmuxesController < ApplicationController
  # POST /response_umuxes
  def create
    @response_umux = ResponseUmux.new(response_umux_params)
    @response_umux.project = Project.find_by uri_token: params[:uri_token]
    @response_umux.respondent_id = request.remote_ip

    respond_to do |format|
      if @response_umux.save
        save_project_response_tracking(@response_umux.project)
        format.html { redirect_to project_public_response_saved_path(locale: @response_umux.project.questionnaire_language_code) }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_umux.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  # DELETE /response_umuxes/1
  # DELETE /response_umuxes/1.json
  def destroy
    @response_umux = ResponseUmux.find(params[:id])
    if current_user != @response_umux.project.user
      redirect_to root_path
      return false
    end
    @response_umux.destroy
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_umux.project
      }
      format.json { head :no_content }
    end
  end

  # GET /response_umuxes/recover/1
  # GET /response_umuxes/recover/1.json
  def recover
    @response_umux = ResponseUmux.only_deleted.find(params[:id])
    @response_umux.recover
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_umux.project
      }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_umux_params
      params.require(:response_umux).permit(:Q1, :Q2, :Q3, :Q4, :ideas, :summary, :age, :gender, :occupation, :first_use_on, :usage_frequency_per_month, :group, :respondent_id, :project_id)
    end
end
