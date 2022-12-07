module ResponseUmuxesHelper

  def umux_chart_for(score)
    html = <<-HTML
    <div class="sus-chart umux-chart">
      <div class="sus-result">
        <span class="result" style="left:#{score}%;"><span class="text">#{score}</span></span>
      </div>
      <div class="sus-score">
        <div class="scale-labels">
          <span class="scale-label">0</span><span class="scale-label">20</span><span class="scale-label">40</span><span class="scale-label">60</span><span class="scale-label">80</span><span class="scale-label">100</span>
        </div>
        <div class="steps">
          <span class="step"></span><span class="step"></span><span class="step"></span><span class="step"></span><span class="step"></span>
        </div>
      </div>
    </div>
    HTML
    html.html_safe
  end

  def umux_portfolio_chart_for(project, umux_lite_scores)
    average_score = umux_lite_scores
    data = {
      datasets: [{
                label: "Moyenne de l'utilisabilité et de l'utilité",
                borderWidth: 5,
                pointRadius: 8,
                pointHoverRadius: 10,
                pointBackgroundColor: "#333333",
                data: [{
                    x: average_score[:Usability][:mean],
                    y: average_score[:Usefullness][:mean]
                }]
            }]
    }
    options = {
      responsive: true,
      class: 'umux-average-chart',
      height: 250,
      scales: {
                xAxes: [{
                    type: 'linear',
                    position: 'bottom',
                    scaleLabel: {
                      display: true,
                      labelString: "Utilisabilité",
                      fontFamily: "'Oswald'",
                      fontSize: 12
                    },
                    ticks: {
                      min: 0,
                      max: 100,
                      stepSize: 20,
                      fontFamily: "'PT Serif'",
                      fontSize: 12
                    }
                }],
                yAxes: [{
                    scaleLabel: {
                      display: true,
                      labelString: "Utilité",
                      fontFamily: "'Oswald'",
                      fontSize: 12
                    },
                    ticks: {
                      min: 0,
                      max: 100,
                      stepSize: 20,
                      fontFamily: "'PT Serif'",
                      fontSize: 12
                    }
                }]
            }
    }
    scatter_chart data, options
  end

end
