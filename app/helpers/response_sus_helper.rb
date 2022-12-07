module ResponseSusHelper

  def sus_chart_for(score, grade)
    css_grade_class = "grade-" + grade[0].downcase

    html = <<-HTML
    <div class="sus-chart">
      <div class="sus-result">
        <span class="result" style="left:#{score}%;"><span class="text">#{score} <span class="ui huge label circular #{css_grade_class}">#{grade}</span></span></span>
      </div>
      <div class="sus-grade">
        <span class="grade grade-f">F</span><span class="grade grade-d">D</span><span class="grade grade-c">C</span><span class="grade grade-b">B</span><span class="grade grade-a">A</span>
      </div>
      <div class="sus-score">
        <div class="scale-labels">
          <span class="scale-label">10</span><span class="scale-label">20</span><span class="scale-label">30</span><span class="scale-label">40</span><span class="scale-label">50</span><span class="scale-label">60</span><span class="scale-label">70</span><span class="scale-label">80</span><span class="scale-label">90</span>
        </div>
        <div class="steps">
          <span class="step"></span><span class="step"></span><span class="step"></span><span class="step"></span><span class="step"></span><span class="step"></span><span class="step"></span><span class="step"></span><span class="step"></span><span class="step"></span>
        </div>
        <div class="scale-special-labels">
          <span class="scale-special-label label-0">0</span>
          <span class="scale-special-label label-25">25<span class="text">Pire imaginable</span></span>
          <span class="scale-special-label label-39">39<span class="text">Mauvais</span></span>
          <span class="scale-special-label label-52">52<span class="text">Acceptable</span></span>
          <span class="scale-special-label label-73">73<span class="text">Bon</span></span>
          <span class="scale-special-label label-86">86<span class="text">Excellent</span></span>
          <span class="scale-special-label label-100">100<span class="text">Meilleur imaginable</span></span>
        </div>
      </div>
    </div>
    HTML
    html.html_safe
  end

  def sus_grade_label_for(sus_grade)
    css_grade_class = "grade-" + sus_grade[0].downcase
    html = <<-HTML
    <span class="ui label circular #{css_grade_class}">#{sus_grade}</span>
    HTML
    html.html_safe
  end

end
