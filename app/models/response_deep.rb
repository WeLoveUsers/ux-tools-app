class ResponseDeep < ApplicationRecord

  acts_as_paranoid

  belongs_to :project

  validates_numericality_of :Q1, :Q2, :Q3, :Q4, :Q5, :Q6, :Q7, :Q8, :Q9, :Q10, :Q11, :Q12, :Q13, :Q14, :Q15, :Q16, :Q17, :Q18, :Q19, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5
  validates_numericality_of :gender, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 2
  validates_numericality_of :age, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99
  validates_numericality_of :usage_frequency_per_month, :group, :only_integer => true, :greater_than_or_equal_to => 0

  Infos = {
    :id => "deep",
    :display_name => "Design-oriented Evaluation of Perceived Web Usability",
    :display_name_short => "DEEP",
    :available_languages => ['fr', 'en'],
    :number_of_questions => 19,
    :description => "<p>Mesure de <strong>l’utilisabilité</strong> des <strong>sites web</strong>.</p><p>Le questionnaire se décompose en 6 dimensions : contenu, strucure, navigation, effort cognitif, cohérence, guidage visuel.</p>",
    :bibliography => ["Lallemand, C., & Gronier, G. (2015). <a href='http://www.eyrolles.com/Informatique/Livre/methodes-de-design-ux-9782212141436' target='_blank'><em>Méthodes de design UX: 30 méthodes fondamentales pour concevoir et évaluer les systèmes interactifs.</em></a> Editions Eyrolles.",
                      'Yang, T., Linder, J., & Bolchini, D. (2012). <a href="http://dx.doi.org/10.1080/10447318.2011.586320" target="_blank">DEEP: design-oriented evaluation of perceived usability. <em>International Journal of Human-Computer Interaction, 28</em></a>(5), 308-346.']
  }

  Export_entete = ["Répondant", "Sexe", "Âge", "Q1", "Q2", "Q3", "Q4", "Q5", "Q6", "Q7", "Q8", "Q9", "Q10", "Q11", "Q12", "Q13", "Q14", "Q15", "Q16", "Q17", "Q18", "Q19", "Métier", "Avis général", "Suggestions", "Date et heure (Paris)"]

  G1_label  = {:fr => "Contenu perçu",
               :en => "Perceived Content"}
  Q1_label  = {:fr => "Le libellé du texte était clair.",
               :en => "The wording of the text was clear."}
  Q2_label  = {:fr => "Le contenu (texte, images, sons, vidéos, etc.) était facile à comprendre.",
               :en => "The content (including text, pictures, audios, and videos etc.) was easy to understand."}
  Q3_label  = {:fr => "Le texte était utile.",
               :en => "The text was useful."}
  Q4_label  = {:fr => "Le texte était pertinent.",
               :en => "The text was relevant."}

  G2_label  = {:fr => "Structure perçue et architecture de l'information",
               :en => "Perceived Structure and Information Architecture"}
  Q5_label  = {:fr => "Je pouvais rapidement connaître la structure du site web en parcourant sa page d'accueil.",
               :en => "I could quickly get to know the structure of the website by skimming its homepage."}
  Q6_label  = {:fr => "L'organisation du site web était claire.",
               :en => "The organization of the website was clear."}
  Q7_label  = {:fr => "Dans chaque section du site web, les pages étaient bien organisées.",
               :en => "Under each section of the website, the web pages were well organized."}


  G3_label  = {:fr => "Navigation perçue",
              :en => "Perceived Navigation"}
  Q8_label  = {:fr => "Il était facile de trouver l'information dont j'avais besoin sur le site web.",
               :en => "It was easy to find the information I needed on the website."}
  Q9_label  = {:fr => "Le site web m'a aidé à trouver ce que je cherchais.",
               :en => "This website helped me find what I was looking for."}
  Q10_label = {:fr => "J'ai obtenu ce à quoi je m'attendais quand je cliquais sur les éléments du site web.",
               :en => "I got what I expected when I clicked on things on this website."}


  G4_label  = {:fr => "Effort cognitif perçu",
             :en => "Perceived Cognitive Effort"}
  Q11_label  = {:fr => "Utiliser ce site web s'est fait sans effort.",
              :en => "Using this website was effortless."}
  Q12_label  = {:fr => "Utiliser ce site web m'a fatigué.",
              :en => "Using this website made me feel tired."}
  Q13_label = {:fr => "J'ai appris à utiliser ce site web rapidement.",
              :en => "I learned to use this website quickly."}

  G5_label  = {:fr => "Cohérence de la mise en page perçue",
             :en => "Perceived Layout Consistency"}
  Q14_label  = {:fr => "La mise en page à travers tout le site web était cohérente.",
              :en => "The layout of the pages throughout the website was consistent."}
  Q15_label  = {:fr => "J'ai remarqué des changements soudains de mise en page à travers le site web.",
              :en => "I noticed abrupt changes in the layout of the pages."}
  Q16_label = {:fr => "La mise en page de chaque section du site web était cohérente.",
              :en => "The layout under each section of the website was consistent."}

  G6_label  = {:fr => "Guidage visuel perçu",
             :en => "Perceived Visual Guidance"}
  Q17_label  = {:fr => "Les couleurs m'ont aidé à distinguer les différentes sections du site web.",
              :en => "The colors helped me to distinguish different sections of the website."}
  Q18_label  = {:fr => "Les zones mises en évidence d'une page m'ont aidé à repérer l'information dont j'avais besoin.",
              :en => "The highlighted areas of a page helped me locate the information I needed;"}
  Q19_label = {:fr => "J'ai appris à connaître le contenu d'une page en parcourant les zones mises en évidence.",
              :en => "I got to know the content of a page by skimming the highlighted areas."}

  def self.generate_instructions(project)
    instructions = ""
    product_name = project.product_name
    if project.questionnaire_language_clean == "francais"
      instructions = <<-HTML
        <div>Veuillez répondre aux questions suivantes d'après votre expérience avec le site web <strong>#{product_name}</strong>.</div>
      HTML
      instructions.html_safe
    elsif project.questionnaire_language_clean == "anglais"
      instructions = <<-HTML
        <div>Please rate the following items based on your experience with the website <strong>#{product_name}</strong>.</div>
      HTML
      instructions.html_safe
    end
    return instructions
  end
  
end
