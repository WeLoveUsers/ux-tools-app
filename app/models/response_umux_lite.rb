class ResponseUmuxLite < ApplicationRecord

  acts_as_paranoid

  belongs_to :project

  validates_numericality_of :Q1, :Q3, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 6
  validates_numericality_of :gender, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 2
  validates_numericality_of :age, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99
  validates_numericality_of :usage_frequency_per_month, :group, :only_integer => true, :greater_than_or_equal_to => 0
  attr_accessor :product_type

  Infos = {
    :id => "umux_lite",
    :display_name => "Usability Metric for User Experience (Lite)",
    :display_name_short => "UMUX (Lite)",
    :available_languages => ['fr', 'en'],
    :number_of_questions => 2,
    :description => "<p>Mesure de <strong>l’utilisabilité</strong> et de <strong>l’utilité</strong> d'un <strong>système</strong>.</p><p>Le score obtenu permet d'estimer le score SUS correspondant.</p>",
    :bibliography => ['Finstad, K. (2010). <a href="https://doi.org/10.1016/j.intcom.2010.04.004" target="_blank">The usability metric for user experience. <em>Interacting with Computers</em></a>, 22(5), 323-327.',
                      "Lallemand, C., & Gronier, G. (2015). <a href='http://www.eyrolles.com/Informatique/Livre/methodes-de-design-ux-9782212141436' target='_blank'><em>Méthodes de design UX: 30 méthodes fondamentales pour concevoir et évaluer les systèmes interactifs.</em></a> Editions Eyrolles.",
                      'Lewis, J. R., Utesch, B. S., & Maher, D. E. (2015). <a href="https://doi.org/10.1007/978-3-319-20886-2_20" target="_blank">Investigating the correspondence between UMUX-LITE and SUS scores. In <em>International conference of design, user experience, and usability</em></a> (pp. 204-211). Springer, Cham.']
  }

  Export_entete = ["Répondant", "Sexe", "Âge", "Q1 (Utilité)", "Q3 (Utilisabilité)", "Score moyen global (/100)", "Métier", "Avis général", "Suggestions", "Date et heure (Paris)"]

  Q1_label = ResponseUmux::Q1_label
  Q3_label = ResponseUmux::Q3_label

  def self.generate_instructions(project)
     instructions = ""
     product_name = project.product_name
     if project.questionnaire_language_clean == "francais"
       instructions = <<-HTML
         <div>Nous souhaitons évaluer de la facilité d'utilisation de <strong>#{product_name}</strong>.</div>
         <div>Des affirmations vont vous être présentées. Veuillez donner votre degré d'accord avec celles-ci (de "pas du tout d'accord" à "tout à fait d'accord").</div>
       HTML
       instructions.html_safe
     elsif project.questionnaire_language_clean == "anglais"
       instructions = <<-HTML
         <div>For each of the following statements, choose what best describes your reactions towards <strong>#{product_name}</strong>.</div>
       HTML
       instructions.html_safe
     end
     return instructions
  end
  
end
