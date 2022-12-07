# Exemple pour UMUX

## 1. Créer le modèle, la migration et le contrôleur
    rails generate resource ResponseUMUX Q1:integer Q2:integer Q3:integer Q4:integer respondent_id:string ideas:text summary:text age:integer gender:integer occupation:string first_use_on:datetime usage_frequency_per_month:integer group:integer project:references deleted_at:datetime:index
    rails generate resource ResponseUMUXLite Q1:integer Q3:integer respondent_id:string ideas:text summary:text age:integer gender:integer occupation:string first_use_on:datetime usage_frequency_per_month:integer group:integer project:references deleted_at:datetime:index

  ET modifier la migration pour mettre :
   - :age,                       :integer,     default: 0
   - :gender,                    :integer,     default: 0
   - :usage_frequency_per_month, :integer,     default: 0
   - :group,                     :integer,     default: 0

## 2. Modifier le modèle
   + acts_as_paranoid
   + validates_numericality_of
   + attr_accessor :product_type
   + Infos = {}
   + Export_entete = {}
   + Q1_label
   + def self.generate_instructions

## 3. Migrer la BDD
   rails db:migrate

## 4. Modifier modèle projet (models/project.rb)
   Ajouter les "hasMany"
   + has_many :response_umuxes, dependent: :destroy

   Ajouter le nouveau questionnaire dans les choix possibles
   ~ def self.questionnaireTypes

   Ajouter le nouveau type de réponses
   ~ responses

   Ajouter la génération des instructions
   ~ generate_instructions

   Ajouter les fonctions de calcul des scores
   + umux_scores

   Voir si utile d'ajouter des fonctions "umux_product_type"

## 5. Ajouter les fonctions de calcul (models/stats.rb)
   + module UMUX
   +   def self.scores(responses)

## 6. Relier les fonctions de calcul (controllers/application_controller.rb)
   ~ load_project_data

## 7. Ajouter la vue pour les résultats (views/projects/results/_umux.html.erb)

## 8. Ajouter la vue pour les réponses (views/projects/responses/_umux.html.erb)

## 9. Ajouter le questionnaire dans le contrôleur projet (controllers/projects_controller.rb)
   ~ def respond

## 10. Ajouter la vue pour les répondants (views/projects/questionnaires/_umux_step1.html.erb)

## 11. Ajouter les traductions (config/locales/fr & en.yml)

## 12. Ajouter les contrôles JS (assets/javascripts/projects.js)

## 13. Ajouter les actions dans le contrôleur (controllers/response_umuxes_controller.rb)

## 14. Ajouter la route pour "recupération" de données

## 15. Ajouter la vue axlsx (views/projects/exports/_umux.xlsx.axlsx)

## 16. Tout vérifier (toutes langues, toutes combinaisons, etc.)

## 17. Mettre en ligne et ajouter la notification
