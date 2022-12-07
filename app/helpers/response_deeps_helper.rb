module ResponseDeepsHelper

  def deep_average_chart_for(deep_scores)
    s = deep_scores
    data = {
      labels: [
        ResponseDeep::G1_label[I18n.locale],
        ResponseDeep::G2_label[I18n.locale],
        ResponseDeep::G3_label[I18n.locale],
        ResponseDeep::G4_label[I18n.locale],
        ResponseDeep::G5_label[I18n.locale],
        ResponseDeep::G6_label[I18n.locale]
      ],
      datasets: [{
          backgroundColor: "#333333",
          borderWidth: 0,
          label: "Valeus moyennes par dimension",
          data: [
            s[:G1][:mean],  s[:G2][:mean],  s[:G3][:mean],  s[:G4][:mean],  s[:G5][:mean],  s[:G6][:mean]
          ]
      }]
    }
    options = {
        title:{
            display:true,
            text:'Diagramme des valeurs moyennes',
            fontFamily: "'Oswald'",
            fontSize: 20
        },
        responsive: true,
        class: 'deep-average-chart',
        height: 410,

        scales: {
            xAxes: [{
                display: true,
                ticks: {
                  min: 1,
                  max: 5,
                  fontFamily: "'PT Serif'",
                  fontSize: 12
                }
            }],
            yAxes: [{
                barThickness: 30,
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

  def deep_radar_chart_for(deep_scores)
    s = deep_scores
    data = {
      labels: [
        ResponseDeep::G1_label[I18n.locale],
        ResponseDeep::G2_label[I18n.locale],
        ResponseDeep::G3_label[I18n.locale],
        ResponseDeep::G4_label[I18n.locale],
        ResponseDeep::G5_label[I18n.locale],
        ResponseDeep::G6_label[I18n.locale]
      ],
      datasets: [{
          #backgroundColor: "#333333",
          borderWidth: 0,
          label: "Valeus moyennes par dimension",
          data: [
            s[:G1][:mean],  s[:G2][:mean],  s[:G3][:mean],  s[:G4][:mean],  s[:G5][:mean],  s[:G6][:mean]
          ]
      }]
    }
    options = {
        title:{
            display:true,
            text:'Diagramme en radar des valeurs moyennes',
            fontFamily: "'Oswald'",
            fontSize: 20
        },
        responsive: true,
        class: 'deep-average-chart',
        height: 410,

        scale: {
            ticks: {
                  min: 1,
                  max: 5,
                  fontFamily: "'PT Serif'",
                  fontSize: 12
                },
            pointLabels: {
              fontFamily: "'PT Serif'",
              fontSize: 13
            }
        }
    }

    radar_chart data, options
  end
end
