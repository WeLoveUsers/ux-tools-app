class ResponseAttrakDiffAbridgedsController < ApplicationController

  # POST /response_attrak_diff_abridgeds
  def create
    @response_attrak_diff_abridged = ResponseAttrakDiffAbridged.new(response_attrak_diff_abridged_params)
    @response_attrak_diff_abridged.project = Project.find_by uri_token: params[:uri_token]
    @response_attrak_diff_abridged.respondent_id = request.remote_ip

    respond_to do |format|
      if @response_attrak_diff_abridged.save
        save_project_response_tracking(@response_attrak_diff_abridged.project)
        format.html { redirect_to project_public_response_saved_path(locale: @response_attrak_diff_abridged.project.questionnaire_language_code) }
      else
        format.html { redirect_to project_public_respond_path(uri_token: @response_attrak_diff_abridged.project.uri_token, step: 1), alert: 'Des erreurs ont été détectées.' }
      end
    end
  end

  # DELETE /response_attrak_diff_abridgeds/1
  # DELETE /response_attrak_diff_abridgeds/1.json
  def destroy
    @response_attrak_diff_abridged = ResponseAttrakDiffAbridged.find(params[:id])
    if current_user != @response_attrak_diff_abridged.project.user
      redirect_to root_path
      return false
    end
    @response_attrak_diff_abridged.destroy
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_attrak_diff_abridged.project
      }
      format.json { head :no_content }
    end
  end

  # GET /response_attrak_diff_abridgeds/recover/1
  # GET /response_attrak_diff_abridgeds/recover/1.json
  def recover
    @response_attrak_diff_abridged = ResponseAttrakDiffAbridged.only_deleted.find(params[:id])
    @response_attrak_diff_abridged.recover
    respond_to do |format|
      format.html {
        session[:back_to_responses] = true
        redirect_to @response_attrak_diff_abridged.project
      }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def response_attrak_diff_abridged_params
      params.require(:response_attrak_diff_abridged).permit(:ATT2, :ATT5, :QP2, :QP3, :QP5, :QP6, :QHS2, :QHS5, :QHI3, :QHI4, :ideas, :summary, :age, :gender, :occupation, :first_use_on, :usage_frequency_per_month, :group, :respondent_id, :project_id)
    end
end
