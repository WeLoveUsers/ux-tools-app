class ResponseUmux < ApplicationRecord

  acts_as_paranoid

  belongs_to :project
  
  validates_numericality_of :Q1, :Q2, :Q3, :Q4, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 6
  validates_numericality_of :gender, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 2
  validates_numericality_of :age, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99
  validates_numericality_of :usage_frequency_per_month, :group, :only_integer => true, :greater_than_or_equal_to => 0
  attr_accessor :product_type

  Infos = {
    :id => "umux",
    :display_name => "Usability Metric for User Experience",
    :display_name_short => "UMUX",
    :available_languages => ['fr', 'en'],
    :number_of_questions => 4,
    :description => "<p>Mesure de <strong>l’utilisabilité</strong> d'un <strong>système</strong>.</p>",
    :bibliography => ['Finstad, K. (2010). <a href="https://doi.org/10.1016/j.intcom.2010.04.004" target="_blank">The usability metric for user experience. <em>Interacting with Computers</em></a>, 22(5), 323-327.',
                      "Lallemand, C., & Gronier, G. (2015). <a href='http://www.eyrolles.com/Informatique/Livre/methodes-de-design-ux-9782212141436' target='_blank'><em>Méthodes de design UX: 30 méthodes fondamentales pour concevoir et évaluer les systèmes interactifs.</em></a> Editions Eyrolles.",]
  }

  Export_entete = ["Répondant", "Sexe", "Âge", "Q1", "Q2", "Q3", "Q4", "Score moyen global (/100)", "Métier", "Avis général", "Suggestions", "Date et heure (Paris)"]

  Q1_label  = {:fr => "Les fonctionnalités de @product_type répondent à mes exigences.",
               :en => "@product_type capabilities meet my requirements."}
  Q2_label  = {:fr => "Utiliser @product_type est une expérience frustrante.",
               :en => "Using @product_type is a frustrating experience."}
  Q3_label  = {:fr => "@product_type est facile à utiliser.",
               :en => "@product_type is easy to use."}
  Q4_label  = {:fr => "Je dois passer trop de temps à corriger des choses sur @product_type.",
               :en => "I have to spend too much time correcting things with @product_type."}

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
