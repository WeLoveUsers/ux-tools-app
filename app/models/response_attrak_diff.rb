class ResponseAttrakDiff < ApplicationRecord

  acts_as_paranoid

  belongs_to :project

  validates_numericality_of :ATT1, :ATT2, :ATT3, :ATT4, :ATT5, :ATT6, :ATT7, :QP1, :QP2, :QP3, :QP4, :QP5, :QP6, :QP7, :QHS1, :QHS2, :QHS3, :QHS4, :QHS5, :QHS6, :QHS7, :QHI1, :QHI2, :QHI3, :QHI4, :QHI5, :QHI6, :QHI7, :only_integer => true, :greater_than_or_equal_to => -3, :less_than_or_equal_to => 3
  validates_numericality_of :gender, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 2
  validates_numericality_of :age, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99
  validates_numericality_of :usage_frequency_per_month, :group, :only_integer => true, :greater_than_or_equal_to => 0

  Infos = {
    :id => "attrakdiff",
    :display_name => "AttrakDiff",
    :display_name_short => "AttrakDiff",
    :available_languages => ['fr', 'en'],
    :number_of_questions => 28,
    :description => "<p>Mesure de <strong>l’expérience utilisateur</strong> d'un <strong>système interactif</strong>.</p><p>Le questionnaire se décompose en 4 dimensions : qualités hédoniques stimulation, qualités hédonique identification, qualités pragmatiques et attractivité globale.</p>",
    :bibliography => ['Hassenzahl, M., Burmester, M., & Koller, F. (2003). <a href="http://attrakdiff.de" target="_blank">AttrakDiff: Ein Fragebogen zur Messung wahrgenommener hedonischer und pragmatischer Qualität. In <em>Mensch & Computer 2003</em></a> (pp. 187-196). Vieweg+ Teubner Verlag. Chicago',
                      'Lallemand, C., Koenig, V., Gronier, G., & Martin, R. (2015). <a href="http://dx.doi.org/10.1016/j.erap.2015.08.002" target="_blank">Création et validation d’une version française du questionnaire AttrakDiff pour l’évaluation de l’expérience utilisateur des systèmes interactifs. <em>Revue Européenne de Psychologie Appliquée/European Review of Applied Psychology, 65</em></a>(5), 239-252. Chicago']
  }

  Export_entete = ["Répondant", "Sexe", "Âge", "ATT1", "ATT2", "ATT3", "ATT4", "ATT5", "ATT6", "ATT7", "QP1", "QP2", "QP3", "QP4", "QP5", "QP6", "QP7", "QHS1", "QHS2", "QHS3", "QHS4", "QHS5", "QHS6", "QHS7", "QHI1", "QHI2", "QHI3", "QHI4", "QHI5", "QHI6", "QHI7", "Métier", "Avis général", "Suggestions", "Date et heure (Paris)"]

  QP1_label  = {:fr => {:bad => "Technique",     :good => "Humain"},
                :en => {:bad => "Technical",     :good => "Human"}}
  QP2_label  = {:fr => {:bad => "Compliqué",     :good => "Simple"},
                :en => {:bad => "Complicated",   :good => "Simple"}}
  QP3_label  = {:fr => {:bad => "Pas pratique",  :good => "Pratique"},
                :en => {:bad => "Impractical",   :good => "Practical"}}
  QP4_label  = {:fr => {:bad => "Fastidieux",    :good => "Efficace"},
                :en => {:bad => "Cumbersome",    :good => "Straightforward"}}
  QP5_label  = {:fr => {:bad => "Imprévisible",  :good => "Prévisible"},
                :en => {:bad => "Unpredictable", :good => "Predictable"}}
  QP6_label  = {:fr => {:bad => "Confus",        :good => "Clair"},
                :en => {:bad => "Confusing",     :good => "Clearly structured"}}
  QP7_label  = {:fr => {:bad => "Incontrôlable", :good => "Maîtrisable"},
                :en => {:bad => "Unruly",        :good => "Manageable"}}

  QHI1_label  = {:fr => {:bad => "M’isole",                  :good => "Me sociabilise"},
                 :en => {:bad => "Isolating",                :good => "Connective"}}
  QHI2_label  = {:fr => {:bad => "Amateur",                  :good => "Professionnel"},
                 :en => {:bad => "Unprofessional",           :good => "Professional"}}
  QHI3_label  = {:fr => {:bad => "De mauvais goût",          :good => "De bon goût"},
                 :en => {:bad => "Tacky",                    :good => "Stylish"}}
  QHI4_label  = {:fr => {:bad => "Bas de gamme",             :good => "Haut de gamme"},
                 :en => {:bad => "Cheap",                    :good => "Premium"}}
  QHI5_label  = {:fr => {:bad => "M’exclut",                 :good => "M’intègre"},
                 :en => {:bad => "Alienating",               :good => "Integrating"}}
  QHI6_label  = {:fr => {:bad => "Me sépare des autres",     :good => "Me rapproche des autres"},
                 :en => {:bad => "Separates me from people", :good => "Brings me closer to people"}}
  QHI7_label  = {:fr => {:bad => "Non présentable",          :good => "Présentable"},
                 :en => {:bad => "Unpresentable",            :good => "Presentable"}}

  QHS1_label  = {:fr => {:bad => "Conventionnel",         :good => "Original"},
                 :en => {:bad => "Conventional",          :good => "Inventive"}}
  QHS2_label  = {:fr => {:bad => "Sans imagination",      :good => "Créatif"},
                 :en => {:bad => "Unimaginative",         :good => "Creative"}}
  QHS3_label  = {:fr => {:bad => "Prudent",               :good => "Audacieux"},
                 :en => {:bad => "Cautious",              :good => "Bold"}}
  QHS4_label  = {:fr => {:bad => "Conservateur",          :good => "Novateur"},
                 :en => {:bad => "Conservative",          :good => "Innovative"}}
  QHS5_label  = {:fr => {:bad => "Ennuyeux",              :good => "Captivant"},
                 :en => {:bad => "Dull",                  :good => "Captivating"}}
  QHS6_label  = {:fr => {:bad => "Peu exigeant",          :good => "Challenging"},
                 :en => {:bad => "Undemanding",           :good => "Challenging"}}
  QHS7_label  = {:fr => {:bad => "Commun",                :good => "Nouveau"},
                 :en => {:bad => "Ordinary",              :good => "Novel"}}

  ATT1_label  = {:fr => {:bad => "Déplaisant",        :good => "Plaisant"},
                 :en => {:bad => "Unpleasant",        :good => "Pleasant"}}
  ATT2_label  = {:fr => {:bad => "Laid",              :good => "Beau"},
                 :en => {:bad => "Ugly",              :good => "Attractive"}}
  ATT3_label  = {:fr => {:bad => "Désagréable",       :good => "Agréable"},
                 :en => {:bad => "Disagreeable",      :good => "Likeable"}}
  ATT4_label  = {:fr => {:bad => "Rebutant",          :good => "Attirant"},
                 :en => {:bad => "Rejecting",         :good => "Inviting"}}
  ATT5_label  = {:fr => {:bad => "Mauvais",           :good => "Bon"},
                 :en => {:bad => "Bad",               :good => "Good"}}
  ATT6_label  = {:fr => {:bad => "Repoussant",        :good => "Attrayant"},
                 :en => {:bad => "Repelling",         :good => "Appealing"}}
  ATT7_label  = {:fr => {:bad => "Décourageant",      :good => "Motivant"},
                 :en => {:bad => "Discouraging",      :good => "Motivating"}}

  def self.generate_instructions(project)
    instructions = ""
    product_name = project.product_name
    if project.questionnaire_language_clean == "francais"
      instructions = <<-HTML
        <div>Dans le cadre d’un projet sur l’expérience utilisateur, nous souhaiterions évaluer vos impressions sur <strong>#{product_name}</strong>.</div>
      	<ul>
      		<li>Ce questionnaire se présente sous forme de paires de mots pour vous assister dans l’évaluation du système.</li>
      		<li>Chaque paire représente des contrastes. Les échelons entre les deux extrémités vous permettent de décrire l’intensité de la qualité choisie.</li>
      		<li>Ne pensez pas aux paires de mots et essayez simplement de donner une réponse spontanée.</li>
      		<li>Vous pourrez avoir l’impression que certains termes ne décrivent pas correctement le système. Dans ce cas, assurez- vous de donner tout de même une réponse.</li>
      		<li>Gardez à l’esprit qu’il n’y a pas de bonne ou mauvaise réponse. Seule votre opinion compte !</li>
      	</ul>
      HTML
      instructions.html_safe
    elsif project.questionnaire_language_clean == "anglais"
      instructions = <<-HTML
        <div>Thank you for taking the time to do this survey with us. With your help, we would like to examine how users perceive the usability and aesthetics of <strong>#{product_name}</strong>. We hope to identify areas for optimization. This will enable us to optimize the product in such a way that it is as efficient and comprehensible as possible.</div>
        <ul>
          <li>The following word pairs will help you for your assessment. They represent stark contrasts and can be subdivided into further rating levels.</li>
          <li>Do not ponder over the word pairs and make your assessment spontaneously.</li>
          <li>You may feel that some word pairs do not fit the product very well. However, we would ask you to give an answer anyway.</li>
          <li>Remember that there are no "right" or "wrong" answers - your personal opinion is what counts.</li>
        </ul>
      HTML
      instructions.html_safe
    end
    return instructions
  end

  # def self.to_csv
  #   attributes = %w{ATT1 ATT2 ATT3 ATT4 ATT5 ATT6 ATT7 QP1 QP2 QP3 QP4 QP5 QP6 QP7 QHS1 QHS2 QHS3 QHS4 QHS5 QHS6 QHS7 QHI1 QHI2 QHI3 QHI4 QHI5 QHI6 QHI7}
  #
  #   CSV.generate(headers: true) do |csv|
  #     csv << attributes
  #
  #     all.each do |response|
  #       csv << attributes.map{ |attr| response.send(attr) }
  #     end
  #   end
  # end
  
end
