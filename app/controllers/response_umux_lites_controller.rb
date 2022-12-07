class ResponseUmuxLitesController < ApplicationController
  # POST /response_umux_lites
  def create
    @response_umux_lite = ResponseUmuxLite.new(response_umux_lite_params)
    @response_umux_lite.project = Project.find_by uri_token: params[:uri_token]
    @response_umux_lite.respondent_id = request.remote_ip

    respond_to do |format|
      if @response_umux_lite.save
        save_project_response_tracking(@response_umux_lite.project)
        format.html { redirect_to project_public_response_saved_path(locale: @response_umux_lite.project.questionnaire_language_code) }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_umux_lite.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  # DELETE /response_umux_lites/1
  # DELETE /response_umux_lites/1.json
  def destroy
    @response_umux_lite = ResponseUmuxLite.find(params[:id])
    if current_user != @response_umux_lite.project.user
      redirect_to root_path
      return false
    end
    @response_umux_lite.destroy
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_umux_lite.project
      }
      format.json { head :no_content }
    end
  end

  # GET /response_umux_lites/recover/1
  # GET /response_umux_lites/recover/1.json
  def recover
    @response_umux_lite = ResponseUmuxLite.only_deleted.find(params[:id])
    @response_umux_lite.recover
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_umux_lite.project
      }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_umux_lite_params
      params.require(:response_umux_lite).permit(:Q1, :Q3, :ideas, :summary, :age, :gender, :occupation, :first_use_on, :usage_frequency_per_month, :group, :respondent_id, :project_id)
    end
end
