class ApplicationController < ActionController::Base

  before_action :setup_app_updates

  def setup_app_updates
    @app_updates = Hash.new()
    @app_updates[:sus_dynamic_instructions_installed_at] = Date.new(2018,2,16)
  end

  def save_project_response_tracking(project)
    cookies.permanent['responded_to_project_' + project.id.to_s] = 1
  end

  def has_already_responded(project)
    has_already_responded = false
    if cookies.permanent['responded_to_project_' + project.id.to_s] && cookies.permanent['responded_to_project_' + project.id.to_s].to_i > 0
      has_already_responded = true
    end
    return has_already_responded
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def authenticate_admin_user
      if !self.authenticate_user! || !current_user.admin?
        redirect_to root_path, alert: 'Cette page est réservée aux administrateurs.'
        return false
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
      if !current_user.admin? && current_user != @project.user
        redirect_to root_path
        return false
      end
    end

    # Load data to avoid running those functions multiple times
    def load_project_data
      @users_stats = @project.users_stats
      case @project.questionnaire_id_clean
        when "attrakdiff", "attrakdiff_abrege"
          @attrakdiff_average_scores          = @project.attrakdiff_average_scores
          @attrakdiff_word_pair_average_score = @project.attrakdiff_word_pair_average_score
        when "system_usability_scale"
          @sus_score = @project.sus_score
          @sus_grade = @project.sus_grade
        when "deep"
          @deep_scores = @project.deep_scores
        when "umux"
          @umux_score = @project.umux_score
        when "umux_lite"
          @umux_score = @project.umux_score
          @umux_lite_scores = @project.umux_lite_scores
      end
    end
    
end
