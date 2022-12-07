class Project < ApplicationRecord

  acts_as_paranoid

  belongs_to :user

  has_many :response_attrak_diffs, dependent: :destroy
  has_many :response_attrak_diff_abridgeds, dependent: :destroy
  has_many :response_sus, dependent: :destroy
  has_many :response_deeps, dependent: :destroy
  has_many :response_umuxes, dependent: :destroy
  has_many :response_umux_lites, dependent: :destroy

  validates_presence_of :questionnaire_id, :questionnaire_language, :product_type, :product_name, :project_code

  before_create :add_token, :generate_instructions

  def self.questionnaireTypes
    [ResponseAttrakDiff::Infos[:display_name], ResponseAttrakDiffAbridged::Infos[:display_name], ResponseSu::Infos[:display_name], ResponseDeep::Infos[:display_name_short], ResponseUmux::Infos[:display_name_short], ResponseUmuxLite::Infos[:display_name_short]]
    #[ResponseAttrakDiff::Infos[:display_name], ResponseSu::Infos[:display_name], ResponseDeep::Infos[:display_name_short]]
  end

  def self.questionnaireLanguages
    ["Français", "Anglais"]
  end

  def self.productTypes
    ["Site Web", "Site E-Commerce", "Application mobile", "Application tablette", "Logiciel", "Autre"]
  end

  def has_responses?
    if !self.responses.nil? && self.responses.count > 0
      return true
    else
      return false
    end
  end

  def questionnaire_id_clean
    if self.questionnaire_id.nil?
      return nil
    else
      return self.questionnaire_id.mb_chars.unicode_normalize(:nfkd).gsub(/[(-)]/,'').gsub(/[^\x00-\x7F]/,'').downcase.gsub(/\s/,'_')
    end
  end

  def questionnaire_language_code
    if self.questionnaire_language.nil?
      return nil
    else
      if self.questionnaire_language_clean == "anglais"
        return 'en'
      else
        return 'fr'
      end
    end
  end

  def questionnaire_language_clean
    if self.questionnaire_language.nil?
      return nil
    else
      return self.questionnaire_language.mb_chars.unicode_normalize(:nfkd).gsub(/[^\x00-\x7F]/n,'').downcase
    end
  end

  def questionnaire_template
    # Ex.: 'projects/questionnaires/system_usability_scale'
    return 'projects' + File::SEPARATOR + 'questionnaires' + File::SEPARATOR + self.questionnaire_id_clean
  end

  def responses
    if self.questionnaire_id_clean == "attrakdiff"
      return self.response_attrak_diffs
    elsif self.questionnaire_id_clean == "attrakdiff_abrege"
      return self.response_attrak_diff_abridgeds
    elsif self.questionnaire_id_clean == "system_usability_scale"
      return self.response_sus
    elsif self.questionnaire_id_clean == "deep"
      return self.response_deeps
    elsif self.questionnaire_id_clean == "umux"
      return self.response_umuxes
    elsif self.questionnaire_id_clean == "umux_lite"
      return self.response_umux_lites
    else
      return nil
    end
  end

  # Teste si le projet devrait avoir le statut "is_closed" d'après les dates
  def should_get_closed
    should_get_closed = false
    if !self.is_closed
      if !self.end_date.nil? && (self.end_date < Date.today)
        should_get_closed = true
      end
    end
    return should_get_closed
  end

  def ask_open_ended_questions
    ask_open_ended_questions = false
    if self.ask_user_ideas || self.ask_user_summary
      ask_open_ended_questions = true
    end
    return ask_open_ended_questions
  end

  def ask_respondent_qualification
    ask_respondent_qualification = false
    if self.ask_user_age || self.ask_user_gender || self.ask_user_occupation || self.ask_user_first_use_date || self.ask_user_usage_frequency || self.ask_user_group
      ask_respondent_qualification = true
    end
    return ask_respondent_qualification
  end

  # System Usability Scale
  def sus_score
    return Stats::SUS::score(self.response_sus)
  end

  def sus_grade
    return Stats::SUS::grade(self.sus_score[:mean])
  end

  def sus_product_type
    case product_type
    when "Site Web"
      {:fr => "ce site web",
      :en => "this website"}
    when "Site E-Commerce"
      {:fr => "ce site e-commerce",
      :en => "this e-commerce website"}
    when "Application mobile"
      {:fr => "cette application mobile",
      :en => "this mobile app"}
    when "Application tablette"
      {:fr => "cette application tablette",
      :en => "this tablet app"}
    when "Logiciel"
      {:fr => "ce logiciel",
      :en => "this software"}
    else
      sus_default_product_type
    end
  end

  def sus_default_product_type
    {:fr => "ce système",
    :en => "this system"}
  end

  # Attrak Diff
  def attrakdiff_average_scores
    abridged = false
    if self.questionnaire_id_clean == "attrakdiff_abrege"
      abridged = true
    end
    return Stats::AttrakDiff::average_scores(self.responses, abridged)
  end

  def attrakdiff_word_pair_average_score
    abridged = false
    if self.questionnaire_id_clean == "attrakdiff_abrege"
      abridged = true
    end
    return Stats::AttrakDiff::word_pair_average_scores(self.responses, abridged)
  end

  # DEEP
  def deep_scores
    return Stats::Deep::average_scores(self.responses)
  end

  # UMUX
  def umux_product_type
    return sus_product_type
  end

  def umux_score
    lite = false
    if self.questionnaire_id_clean == "umux_lite"
      lite = true
    end
    return Stats::UMUX::score(self.responses, lite)
  end

  def umux_lite_scores
    return Stats::UMUX::lite_scores(self.responses)
  end

  def generate_instructions
    instructions = ""
    product_name = self.product_name
    if self.questionnaire_id_clean == "attrakdiff"
      instructions = ResponseAttrakDiff::generate_instructions(self)
    elsif self.questionnaire_id_clean == "attrakdiff_abrege"
      instructions = ResponseAttrakDiffAbridged::generate_instructions(self)
    elsif self.questionnaire_id_clean == "system_usability_scale"
      instructions = ResponseSu::generate_instructions(self)
    elsif self.questionnaire_id_clean == "deep"
      instructions = ResponseDeep::generate_instructions(self)
    elsif self.questionnaire_id_clean == "umux"
      instructions = ResponseUmux::generate_instructions(self)
    elsif self.questionnaire_id_clean == "umux_lite"
      instructions = ResponseUmuxLite::generate_instructions(self)
    end
    self.instructions = instructions
  end

  #User Age & Gender
  def users_stats
    Stats::Users::average_data(self.responses)
  end

  private
  def add_token
    begin
      self.uri_token = SecureRandom.hex[0,20].upcase
    rescue ActiveRecord::RecordNotUnique
      retry
    end while self.class.exists?(uri_token: uri_token)
  end

end
