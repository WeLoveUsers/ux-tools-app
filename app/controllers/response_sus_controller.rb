class ResponseSusController < ApplicationController

  # POST /response_sus
  def create
    @response_su = ResponseSu.new(response_su_params)
    @response_su.project = Project.find_by uri_token: params[:uri_token]
    @response_su.respondent_id = request.remote_ip

    respond_to do |format|
      if @response_su.save
        save_project_response_tracking(@response_su.project)
        format.html { redirect_to project_public_response_saved_path(locale: @response_su.project.questionnaire_language_code) }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_su.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  # DELETE /response_sus/1
  # DELETE /response_sus/1.json
  def destroy
    @response_su = ResponseSu.find(params[:id])
    if current_user != @response_su.project.user
      redirect_to root_path
      return false
    end
    @response_su.destroy
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_su.project
      }
      format.json { head :no_content }
    end
  end

  # GET /response_sus/recover/1
  # GET /response_sus/recover/1.json
  def recover
    @response_su = ResponseSu.only_deleted.find(params[:id])
    @response_su.recover
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_su.project
      }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_su_params
      params.require(:response_su).permit(:Q1, :Q2, :Q3, :Q4, :Q5, :Q6, :Q7, :Q8, :Q9, :Q10, :ideas, :summary, :age, :gender, :occupation, :first_use_on, :usage_frequency_per_month, :group, :respondent_id, :project_id)
    end
end
