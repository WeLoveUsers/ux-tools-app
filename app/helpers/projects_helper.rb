module ProjectsHelper

  def gender_icon_for(gender)
    html = ''
    if gender == 1
      html = '<i class="icon venus"></i>'
    elsif gender == 2
      html = '<i class="icon mars"></i>'
    end
    html.html_safe
  end

  def gender_graph_stats_for(users_gender_mean)
    html = '-'
    if users_gender_mean > 0
      female_width = ((2 - users_gender_mean)*100).round
      female_percent = ((2 - users_gender_mean)*100).round(2)
      male_width = ((users_gender_mean - 1)*100).round
      male_percent = ((users_gender_mean - 1)*100).round(2)
      split_width = 2
      if female_width < 2
        female_width = 2
        male_width = 96
      elsif male_width < 2
        male_width = 2
        female_width = 96
      else
        female_width = female_width - 1
        male_width = male_width - 1
      end
      html = <<-HTML
        <div class="gender">
          <div class="data">
            <div class="female bar" style="width:#{female_width}%"></div><div class="split bar" style="width:#{split_width}%"></div><div class="male bar" style="width:#{male_width}%"></div>
          </div>
          <div class="label">
            <div class="female"><i class="icon venus"></i><span class="percent">#{female_percent}%</span></div><div class="male"><i class="icon mars"></i><span class="percent">#{male_percent}%</span></div>
          </div>
        </div>
      HTML
    end
    html.html_safe
  end

  def human_date_for(date)
    l date, format: :long
  end

  def end_date_for(project)
    if project.end_date.nil?
      "-"
    else
      l project.end_date, format: :long
    end
  end

  def end_date_full_for(project)
    html = end_date_for(project)
    if !project.end_date.nil?
      html = '<i class="icon popup calendar alternate"></i> ' + html
    end
    html.html_safe
  end

  def are_multiple_responses_allowed_for(project)
    if project.forbid_multiple_reponses
      "Interdites"
    else
      "Autorisées"
    end
  end

  def status_for(project)
    html = ""
    if project.is_closed
      html = '<span class="popup" data-html="Ce projet est <b>fermé</b> et n\'accepte pas les réponses"><span class="ui red empty circular label"></span></span>'
    else
      if project.end_date.nil?
        html = '<span class="popup" data-html="Ce projet est <b>ouvert</b> et accepte les réponses"><span class="ui green empty circular label"></span></span>'
      else
        html = '<span class="popup" data-html="Ce projet est <b>ouvert</b> et accepte les réponses"><span class="ui green empty circular label"></span></span> <i class="icon popup calendar" data-html="' + 'La <b>fermeture automatique</b> aura lieu le :<br />' + end_date_for(project) + '"></i>'
      end
    end
    html.html_safe
  end

  def status_full_for(project)
    html = ""
    if project.is_closed
      html = '<span class="ui red empty circular label"></span> <span>Ce projet est <b>fermé</b> et n\'accepte pas les réponses</span>'
    else
      if project.end_date.nil?
        html = '<span class="ui green empty circular label"></span> <span>Ce projet est <b>ouvert</b> et accepte les réponses</span>'
      else
        html = '<span class="ui green empty circular label"></span> <span>Ce projet est <b>ouvert</b> et accepte les réponses</span>'
      end
    end
    html.html_safe
  end

  def dropdown_for_order_by(order_by_possible_values, order_by_selected_value)
    hint_text = order_by_possible_values[order_by_selected_value]
    active_class = 'active selected'

    html = <<-HTML
      <div class="ui fluid projects_order selection dropdown"> Ordonner :
        <div class="text">#{hint_text}</div>
        <input type="hidden" name="order_by">
        <i class="dropdown icon"></i>
        <div class="menu">
    HTML

    order_by_possible_values.each do |data_value, description|
      if data_value == 'divider'
        html += '<div class="divider"></div>'
      else
        html += '<div class="item '
        if data_value == order_by_selected_value
          html +=active_class
        end
        html += '" data-value="' + data_value + '">' + description + '</div>'
      end
    end

    html += '</div></div>'
    html.html_safe
  end

end
