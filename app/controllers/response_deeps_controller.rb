class ResponseDeepsController < ApplicationController

  # POST /response_deeps
  def create
    @response_deep = ResponseDeep.new(response_deep_params)
    @response_deep.project = Project.find_by uri_token: params[:uri_token]
    @response_deep.respondent_id = request.remote_ip

    respond_to do |format|
      if @response_deep.save
        save_project_response_tracking(@response_deep.project)
        format.html { redirect_to project_public_response_saved_path(locale: @response_deep.project.questionnaire_language_code) }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_deep.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  # DELETE /response_deeps/1
  # DELETE /response_deeps/1.json
  def destroy
    @response_deep = ResponseDeep.find(params[:id])
    if current_user != @response_deep.project.user
      redirect_to root_path
      return false
    end
    @response_deep.destroy
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_deep.project
      }
      format.json { head :no_content }
    end
  end

  # GET /response_deeps/recover/1
  # GET /response_deeps/recover/1.json
  def recover
    @response_deep = ResponseDeep.only_deleted.find(params[:id])
    @response_deep.recover
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_deep.project
      }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_deep_params
      params.require(:response_deep).permit(:Q1, :Q2, :Q3, :Q4, :Q5, :Q6, :Q7, :Q8, :Q9, :Q10, :Q11, :Q12, :Q13, :Q14, :Q15, :Q16, :Q17, :Q18, :Q19, :ideas, :summary, :age, :gender, :occupation, :first_use_on, :usage_frequency_per_month, :group, :respondent_id, :project_id)
    end
end
