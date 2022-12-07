class ResponseSu < ApplicationRecord

  acts_as_paranoid

  belongs_to :project

  validates_numericality_of :Q1, :Q2, :Q3, :Q4, :Q5, :Q6, :Q7, :Q8, :Q9, :Q10, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 4
  validates_numericality_of :gender, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 2
  validates_numericality_of :age, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99
  validates_numericality_of :usage_frequency_per_month, :group, :only_integer => true, :greater_than_or_equal_to => 0
  attr_accessor :product_type

  Infos = {
    :id => "sus",
    :display_name => "System Usability Scale",
    :display_name_short => "SUS",
    :available_languages => ['fr', 'en'],
    :number_of_questions => 10,
    :description => "<p>Mesure de <strong>l’utilisabilité</strong> d'un <strong>système</strong>.</p><p>Le questionnaire peut également fournir une mesure de l'apprentissage (<em>learnability</em>).</p>",
    :bibliography => ['Bangor, A., Kortum, P., & Miller, J. (2009). <a href="http://dl.acm.org/citation.cfm?id=2835589" target="_blank">Determining what individual SUS scores mean: Adding an adjective rating scale. <em>Journal of usability studies, 4</em></a>(3), 114-123.',
                      'Brooke, J. (1996). <a href="http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.232.5526" traget="_blank">SUS: A "quick and dirty" usability scale.</a> In P. W. Jordan, B. Thomas, B. A. Weerdmeester, & A. L. McClelland (Eds.), Usability Evaluation in Industry. London: Taylor and Francis.',
                      "Lallemand, C., & Gronier, G. (2015). <a href='http://www.eyrolles.com/Informatique/Livre/methodes-de-design-ux-9782212141436' target='_blank'><em>Méthodes de design UX: 30 méthodes fondamentales pour concevoir et évaluer les systèmes interactifs.</em></a> Editions Eyrolles.",
                      'Sauro, J., & Lewis, J. R. (2012). <a href="https://www.elsevier.com/books/quantifying-the-user-experience/unknown/978-0-12-802308-2" target="_blank"><em>Quantifying the user experience: Practical statistics for user research.</em></a> Elsevier.']
  }

  Export_entete = ["Répondant", "Sexe", "Âge", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8", "Q9", "Q10", "Score SUS", "Métier", "Avis général", "Suggestions", "Date et heure (Paris)"]

  Q1_label  = {:fr => "Je pense que j'aimerais utiliser @product_type fréquemment.",
               :en => "I think that I would like to use @product_type frequently."}
  Q2_label  = {:fr => "J'ai trouvé @product_type inutilement complexe.",
               :en => "I found @product_type unnecessarily complex."}
  Q3_label  = {:fr => "J'ai trouvé @product_type facile à utiliser.",
               :en => "I thought @product_type was easy to use."}
  Q4_label  = {:fr => "Je pense que j'aurais besoin d'un support technique pour être capable d'utiliser @product_type.",
               :en => "I think that I would need the support of a technical person to be able to use @product_type."}
  Q5_label  = {:fr => "J'ai trouvé que les différentes fonctions de @product_type étaient bien intégrées.",
               :en => "I found the various functions in @product_type were well integrated."}
  Q6_label  = {:fr => "J'ai trouvé qu'il y avait trop d'incohérence dans @product_type.",
               :en => "I thought there was too much inconsistency in @product_type."}
  Q7_label  = {:fr => "Je suppose que la plupart des gens apprendraient très rapidement à utiliser @product_type.",
               :en => "I would imagine that most people would learn to use @product_type very quickly."}
  Q8_label  = {:fr => "J'ai trouvé @product_type très contraignant à utiliser.",
               :en => "I found @product_type very cumbersome to use."}
  Q9_label  = {:fr => "Je me suis senti(e) très confiant(e) en utilisant @product_type.",
               :en => "I felt very confident using @product_type."}
  Q10_label = {:fr => "J'ai du apprendre beaucoup de choses avant de me sentir familiarisé(e) avec @product_type.",
               :en => "I needed to learn a lot of things before I could get going with @product_type."}


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
