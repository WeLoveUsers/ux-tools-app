module ResponseAttrakDiffsHelper

  def attrak_diff_average_chart_for(project, attrakdiff_average_scores)
    data = {
      labels: ["QP", "QHS", "QHI", "ATT"],
      datasets: [
        {
            label: "Valeurs moyennes",
            borderWidth: 5,
            fill: false,
            showLine: false,
            pointRadius: 8,
            pointHoverRadius: 10,
            pointBackgroundColor: "#333333",
            data: [
              attrakdiff_average_scores[:QP][:mean],
              attrakdiff_average_scores[:QHS][:mean],
              attrakdiff_average_scores[:QHI][:mean],
              attrakdiff_average_scores[:ATT][:mean]
            ]
        }
      ]
    }
    options = {
      title:{
        display: true,
        text:'Diagramme des valeurs moyennes',
        fontFamily: "'Oswald'",
        fontSize: 20
      },
      responsive: true,
      class: 'attrak-diff-average-chart',
      height: 300,
      scales: {
                xAxes: [{
                  ticks: {
                    fontFamily: "'PT Serif'",
                    fontSize: 12
                  }
                }],
                yAxes: [{
                    ticks: {
                      min: -3,
                      max: 3,
                      fontFamily: "'PT Serif'",
                      fontSize: 12
                    }
                }]
            }
    }

    line_chart data, options
  end

  def attrak_diff_word_pair_chart_for(project, attrakdiff_word_pair_average_score)
    s = attrakdiff_word_pair_average_score
    data = {
      labels: [
        'Technique - Humain',
        'Compliqué - Simple',
        'Pas pratique - Pratique',
        'Fastidieux - Efficace',
        'Imprévisible - Prévisible',
        'Confus - Clair',
        'Incontrôlable - Maîtrisable',
        'Conventionnel - Original',
        'Sans imagination - Créatif',
        'Prudent - Audacieux',
        'Conservateur - Novateur',
        'Ennuyeux - Captivant',
        'Peu exigeant - Challeging',
        'Commun - Nouveau',
        "M'isole - Me sociabilise",
        'Amateur - Professionnel',
        'De mauvais goût - De bon goût',
        'Bas de gamme - Haut de gamme',
        "M'exclut - M'intègre",
        'Me sépare des autres - Me rapproche des autres',
        'Non présentable - Présentable',
        'Déplaisant - Plaisant',
        'Laid - Beau',
        'Désagréable - Agréable',
        'Rebutant - Attirant',
        'Mauvais - Bon',
        'Repoussant - Attrayant',
        'Décourageant - Motivant'
      ],
      datasets: [{
          backgroundColor: "#333333",
          borderWidth: 0,
          label: "Valeus moyennes par paires de mots",
          data: [
            s[:QP1],  s[:QP2],  s[:QP3],  s[:QP4],  s[:QP5],  s[:QP6],  s[:QP7],
            s[:QHS1], s[:QHS2], s[:QHS3], s[:QHS4], s[:QHS5], s[:QHS6], s[:QHS7],
            s[:QHI1], s[:QHI2], s[:QHI3], s[:QHI4], s[:QHI5], s[:QHI6], s[:QHI7],
            s[:ATT1], s[:ATT2], s[:ATT3], s[:ATT4], s[:ATT5], s[:ATT6], s[:ATT7]
          ]
      }]
    }
    options = {
        title:{
            display:true,
            text:'Diagramme des paires de mots',
            fontFamily: "'Oswald'",
            fontSize: 20
        },
        responsive: true,
        class: 'attrak-diff-word-pair-chart',
        height: 410,

        scales: {
            xAxes: [{
                display: true,
                ticks: {
                  min: -3,
                  max: 3,
                  fontFamily: "'PT Serif'",
                  fontSize: 12
                }
            }],
            yAxes: [{
                barThickness: 15,
                position: 'left',
                display: true,
                ticks: {
                  fontFamily: "'PT Serif'",
                  fontSize: 12
                }
            }]
        }
    }

    horizontal_bar_chart data, options
  end

  def attrak_diff_abridged_word_pair_chart_for(project, attrakdiff_word_pair_average_score)
    s = attrakdiff_word_pair_average_score
    data = {
      labels: [
        'Compliqué - Simple',
        'Pas pratique - Pratique',
        'Imprévisible - Prévisible',
        'Confus - Clair',
        'Sans imagination - Créatif',
        'Ennuyeux - Captivant',
        'De mauvais goût - De bon goût',
        'Bas de gamme - Haut de gamme',
        'Laid - Beau',
        'Mauvais - Bon'
      ],
      datasets: [{
          backgroundColor: "#333333",
          borderWidth: 0,
          label: "Valeus moyennes par paires de mots",
          data: [
            s[:QP2],  s[:QP3],  s[:QP5],  s[:QP6],
            s[:QHS2], s[:QHS5],
            s[:QHI3], s[:QHI4],
            s[:ATT2], s[:ATT5]
          ]
      }]
    }
    options = {
        title:{
            display:true,
            text:'Diagramme des paires de mots',
            fontFamily: "'Oswald'",
            fontSize: 20
        },
        responsive: true,
        class: 'attrak-diff-word-pair-chart',
        height: 280,

        scales: {
            xAxes: [{
                display: true,
                ticks: {
                  min: -3,
                  max: 3,
                  fontFamily: "'PT Serif'",
                  fontSize: 12
                }
            }],
            yAxes: [{
                barThickness: 15,
                position: 'left',
                display: true,
                ticks: {
                  fontFamily: "'PT Serif'",
                  fontSize: 12
                }
            }]
        }
    }

    horizontal_bar_chart data, options

  end

  def attrak_diff_portfolio_chart_for(project, attrakdiff_average_scores)
    average_score = attrakdiff_average_scores
    data = {
      datasets: [{
                label: 'Moyenne pragmatique et hédonique',
                borderWidth: 5,
                pointRadius: 8,
                pointHoverRadius: 10,
                pointBackgroundColor: "#333333",
                data: [{
                    x: average_score[:QP][:mean],
                    y: (average_score[:QHS][:mean] + average_score[:QHI][:mean]) / 2
                }]
            }]
    }
    options = {
      title:{
          display:true,
          text:'Portfolio des résultats',
          fontFamily: "'Oswald'",
          fontSize: 20
      },
      responsive: true,
      class: 'attrak-diff-average-chart',
      height: 300,
      scales: {
                xAxes: [{
                    type: 'linear',
                    position: 'bottom',
                    scaleLabel: {
                      display: true,
                      labelString: "Qualité pragmatique",
                      fontFamily: "'Oswald'",
                      fontSize: 12
                    },
                    ticks: {
                      min: -3,
                      max: 3,
                      fontFamily: "'PT Serif'",
                      fontSize: 12
                    }
                }],
                yAxes: [{
                    scaleLabel: {
                      display: true,
                      labelString: "Qualité hédonique",
                      fontFamily: "'Oswald'",
                      fontSize: 12
                    },
                    ticks: {
                      min: -3,
                      max: 3,
                      fontFamily: "'PT Serif'",
                      fontSize: 12
                    }
                }]
            }
    }
    scatter_chart data, options
  end
end
