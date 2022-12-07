class ResponseAttrakDiffAbridged < ApplicationRecord

  acts_as_paranoid

  belongs_to :project

  validates_numericality_of :ATT2, :ATT5, :QP2, :QP3, :QP5, :QP6, :QHS2, :QHS5, :QHI3, :QHI4, :only_integer => true, :greater_than_or_equal_to => -3, :less_than_or_equal_to => 3
  validates_numericality_of :gender, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 2
  validates_numericality_of :age, :only_integer => true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 99
  validates_numericality_of :usage_frequency_per_month, :group, :only_integer => true, :greater_than_or_equal_to => 0

  Infos = {
    :id => "attrakdiff_abridged",
    :display_name => "AttrakDiff (abrégé)",
    :display_name_short => "AttrakDiff (abrégé)",
    :available_languages => ['fr', 'en'],
    :number_of_questions => 10,
    :description => "<p>Mesure de <strong>l’expérience utilisateur</strong> d'un <strong>système interactif</strong>.</p><p>Le questionnaire se décompose en 4 dimensions : qualités hédoniques stimulation, qualités hédonique identification, qualités pragmatiques et attractivité globale.</p>",
    :bibliography => ['Hassenzahl, M., Burmester, M., & Koller, F. (2003). <a href="http://attrakdiff.de" target="_blank">AttrakDiff: Ein Fragebogen zur Messung wahrgenommener hedonischer und pragmatischer Qualität. In <em>Mensch & Computer 2003</em></a> (pp. 187-196). Vieweg+ Teubner Verlag. Chicago',
                      'Lallemand, C., Koenig, V., Gronier, G., & Martin, R. (2015). <a href="http://dx.doi.org/10.1016/j.erap.2015.08.002" target="_blank">Création et validation d’une version française du questionnaire AttrakDiff pour l’évaluation de l’expérience utilisateur des systèmes interactifs. <em>Revue Européenne de Psychologie Appliquée/European Review of Applied Psychology, 65</em></a>(5), 239-252. Chicago']
  }

  Export_entete = ["Répondant", "Sexe", "Âge", "ATT2", "ATT5", "QP2", "QP3", "QP5", "QP6", "QHS2", "QHS5", "QHI3", "QHI4", "Métier", "Avis général", "Suggestions", "Date et heure (Paris)"]

  QP2_label = ResponseAttrakDiff::QP2_label
  QP3_label = ResponseAttrakDiff::QP3_label
  QP5_label = ResponseAttrakDiff::QP5_label
  QP6_label = ResponseAttrakDiff::QP6_label

  QHI3_label = ResponseAttrakDiff::QHI3_label
  QHI4_label = ResponseAttrakDiff::QHI4_label

  QHS2_label = ResponseAttrakDiff::QHS2_label
  QHS5_label = ResponseAttrakDiff::QHS5_label

  ATT2_label = ResponseAttrakDiff::ATT2_label
  ATT5_label = ResponseAttrakDiff::ATT5_label

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
  
end
