class ResponseAttrakDiffsController < ApplicationController

  # POST /response_attrak_diffs
  def create
    @response_attrak_diff = ResponseAttrakDiff.new(response_attrak_diff_params)
    @response_attrak_diff.project = Project.find_by uri_token: params[:uri_token]
    @response_attrak_diff.respondent_id = request.remote_ip

    respond_to do |format|
      if @response_attrak_diff.save
        save_project_response_tracking(@response_attrak_diff.project)
        format.html { redirect_to project_public_response_saved_path(locale: @response_attrak_diff.project.questionnaire_language_code) }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_attrak_diff.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  # DELETE /response_attrak_diffs/1
  # DELETE /response_attrak_diffs/1.json
  def destroy
    @response_attrak_diff = ResponseAttrakDiff.find(params[:id])
    if current_user != @response_attrak_diff.project.user
      redirect_to root_path
      return false
    end
    @response_attrak_diff.destroy
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_attrak_diff.project
      }
      format.json { head :no_content }
    end
  end

  # GET /response_attrak_diffs/recover/1
  # GET /response_attrak_diffs/recover/1.json
  def recover
    @response_attrak_diff = ResponseAttrakDiff.only_deleted.find(params[:id])
    @response_attrak_diff.recover
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_attrak_diff.project
      }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_attrak_diff_params
      params.require(:response_attrak_diff).permit(:ATT1, :ATT2, :ATT3, :ATT4, :ATT5, :ATT6, :ATT7, :QP1, :QP2, :QP3, :QP4, :QP5, :QP6, :QP7, :QHS1, :QHS2, :QHS3, :QHS4, :QHS5, :QHS6, :QHS7, :QHI1, :QHI2, :QHI3, :QHI4, :QHI5, :QHI6, :QHI7, :ideas, :summary, :age, :gender, :occupation, :first_use_on, :usage_frequency_per_month, :group, :respondent_id, :project_id)
    end
end
