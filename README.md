# README

@TODO :
- Timer :
  - Permettre la desactivation du son
  - Alléger le code JS timer pour supprimer les ms (performance)
  - Bugs sous Firefox (popup & fullscreen) / Safari

- Aide :
  - Contrôler la validité des réponses et exclures ?
  - Choisir (ou aider ?) le type d'étude : A vs B ; Avant / Après ; Groupe 1 vs Groupe 2
  - Donner des recommandations sur la taille de l'échantillon ? (avant ou pendant l'évaluation)
  - IC /ecart type
  - Transparence technologique sur les formules utilisées (ex. comment sont calculés les IC ?)

- UI :
  - Ajouter des filtres pour les dates / statuts des projets
  - Pouvoir créer des dossiers de projet (nous réalisons souvent des tests sur les memes projets, en cycle itératif / sprint de dév). retrouver tous les tests associés à un meme projet dans le meme dossier serait pratique.
  - [X] Masquer les réponses supprimées
  - attrakDiff : schéma plus classe

- Stats :
  - Ajouter des barres d'erreur pour les IC
  - Revoir calcul des stats pour "attrakdiff_word_pair_average_score"

- Ajouter :
  - SUS "positif"
  - WAMMI
  - UEQ
  - KANO
  - UTAUT > TAM
  - AttrakDiff paginé

- Routes ou pages pour erreurs 404 et 500

- Ajouter des questions sur le participant :
  - Finaliser : groupe d'utilisateurs, fréquence d'utilisation, première utilisation
  - Permettre d'annoter des réponses en BO ?
  - Afficher le métier (++) dans le tableau plutôt que uniquement dans l'Excel
  - Faire un export uniquement des commentaires / idées
  - Réponse > Etape 3 > Afficher les messages d'erreur suite au contrôle JS
  - Permettre de charger 50 réponses passées en plus ou paginer, etc. Le problème étant de pouvoir supprimer une donnée...
  - Auto-suppression comptes
  - Contraste des checkboxes + messages d'erreur

@RELEASES
V1.2.11 :
- Ajout des validateurs pour gender, age, group
- Ajout de UMUX et UMUX-Lite

V1.2.10 :
- Traductions anglais
- Corrections CSS

V1.2.9 :
- Logs plus concis et par de "debug / info" en production
- Changement charte graphique
- MAJ modules (Fomantic, CXLS, ChartJS)

V1.2.8 :
- Version smartphone + tablette (+MAJ ordi) pour la partie publique (réponses)
- Bug pour nouveau compte avec les notifications

V1.2.7 :
- MAJ admin pour voir combien de personnes ont lu les notifications

V1.2.6 :
- Correction : problème d'ordre dans les réponses exportées (XLS) VS réponses affichées (WEB)
- MAJ Semantic (nouvelles icônes)
- Âge, sexe, profession/occupation, avis général, suggestions/idées :
- 40 résultats maxi dans le tableau
- Performance affichage projet avec beaucoup de réponses

V1.2.5 :
- Suppression Smartlook
- Montrer un petit message "Nouveautés" et le descriptif

V1.2.4 :
- Possibilité d'interdire les réponses multiples (bdd + cookies)
- Suppression d'un "n" dans une regex

v1.2.3 :
- MAJ Admin

v1.2.2 :
- Affichage des réponses sous forme de tableau
- Possibilité de supprimer et récupérer une réponse (suppression logique)
- Restructuration du code pour les stats (Module / Sous-module)

v1.2.1 :
- Spécification de la Timezone (Paris)

v1.2 :
- Bugs :
  - Modal sur fond blanc
- Exports XLS :
  - Ajout des stats synthétiques pour AttrakDiff et DEEP
  - Ajout des références aux publications
- Questionnaires UX :
  - La date de fin devient optionnelle
  - Ajout d'un statut au proget (Ouvert / Fermé)
  - Ajout d'un champ "Ordonner par..."
  - Ajout des intervalles de confiance et écart-types pour DEEP
- Invisible :
  - Ajout d'un (daily) job automatique pour basculer les statuts des projets (voir doc : https://devcenter.heroku.com/articles/scheduler)

v1.1.14 :
- Ajout de données dans l'export SUS
- Correction dans le Timer (continue après modification du temps + focus on click)

v1.1.13 :
- Suppression Yandex
- Correction fil d'Ariane pour le compte à rebourds

v1.1.12 :
- Bug IC
- Rajout jquery_ujs

v1.1.11 :
- Ajout Yandex.Metrica
- Activation AttrakDiff abrégé
- Suppression jquery_ujs

v1.1.10 :
- Ajout Smartlook (current_user && !admin)

v1.1.9 :
- Ajout du timer
- Ajout du code et table pour AttrakDiff abrégé mais desactivé (test de non régression à faire)

v1.1.8 :
- Bug dans l'enregistrement de date
- Ajout références et remerciements
- Ajout des écart-types et des IC sur SUS

v1.1.7 :
- Ajout des écart-types et des IC sur AttrakDiff
- Ajout de liens dans la partie admin

v1.1.6 :
- Mise à jour de l'admin
- Correction affichage tableau dans DEEP

v1.1.5 :
- div > a dans la nav
- Mise à jour des références

v1.1.4 :
- Modif lien UserReport
- Ajout d'un champ "admin" sur "users" et d'une page /admin

v1.1.3 :
- Correction de coquilles dans DEEP

v1.1.2 :
- MAJ des conditions d'utilisation avec ajout des lien vers les références

v1.1.1 :
- Ajouter des conditions d'utilisation
- MAJ des checkboxes et radio

v1.1 :
- Permettre de modifier le texte de la consigne
- Export XLS revu
- Intégration de UserReport pour la gestion de bugs et d'idées
- Ajout du questionnaire DEEP
