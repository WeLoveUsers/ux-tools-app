module SampleSizesHelper

  def usability_problems_char_for(proportion, max_users)
    l = proportion
    xValue = (0..max_users).to_a
    yValues = []
    xValue.each do |v|
      yValues << ((1 - ( 1 - l) ** v) * 100).round(2)
    end

    data = {
      labels: xValue,
      datasets: [
        {
            label: "Pourcentage de problèmes trouvés",
            borderWidth: 5,
            fill: false,
            pointRadius: 4,
            pointHoverRadius: 6,
            pointBackgroundColor: "#333333",
            data: yValues
        }
      ]
    }
    options = {
      title:{
        display: false,
        text:"Proportion des problèmes d'utilisabilité trouvés en fonction du nombre d'utilisateurs",
        fontFamily: "'Oswald'",
        fontSize: 20
      },
      responsive: true,
      height: 200,
      scales: {
                xAxes: [{
                  ticks: {
                    fontFamily: "'PT Serif'",
                    fontSize: 12
                  },
                  scaleLabel: {
                    display: true,
                    labelString: "Nombre d'utilisateurs pour le test",
                    fontFamily: "'Oswald'",
                    fontSize: 12
                  },
                }],
                yAxes: [{
                    ticks: {
                      min: 0,
                      max: 100,
                      fontFamily: "'PT Serif'",
                      fontSize: 12
                    },
                    scaleLabel: {
                      display: true,
                      labelString: "Problèmes trouvés (%)",
                      fontFamily: "'Oswald'",
                      fontSize: 12
                    },
                }]
            }
    }

    line_chart data, options
  end
end
