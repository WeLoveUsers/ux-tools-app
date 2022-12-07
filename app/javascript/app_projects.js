$(document).on('turbo:load', function() {

  $('.ui.selection.projects_order.dropdown').dropdown({
    onChange: function(value, text, $choice) {
      $(this).parent().parent('form').submit();
    }
  });

  $('.ui.checkbox#show_variability').checkbox({
    onChecked: function() {
      $('.variability').show();
      document.cookie = "show_variability=1";
    },
    onUnchecked: function() {
      $('.variability').hide();
      document.cookie = "show_variability=0";
    }
  });

  $('.ui.sus_confidence.dropdown').dropdown({
    onChange: function(value, text, $choice) {
      if (!this.target) {
        this.target = $('#' + $(this).data('target'));
      }
      document.cookie = "ci_level=" + text;
      this.target.text(value);
      this.target.transition('flash');
    }
  });

  $('.ui.attrakdiff_confidence.dropdown').dropdown({
    onChange: function(value, text, $choice) {
      if (!this.target_QP || !this.target_QHS || !this.target_QHI || !this.target_ATT ) {
        this.target_QP  = $('#' + $(this).data('target') + '_QP');
        this.target_QHS = $('#' + $(this).data('target') + '_QHS');
        this.target_QHI = $('#' + $(this).data('target') + '_QHI');
        this.target_ATT = $('#' + $(this).data('target') + '_ATT');
      }
      document.cookie = "ci_level=" + text;
      value = value.split("_");
      this.target_QP.text(value[0]);
      this.target_QHS.text(value[1]);
      this.target_QHI.text(value[2]);
      this.target_ATT.text(value[3]);
      this.target_QP.transition('flash');
      this.target_QHS.transition('flash');
      this.target_QHI.transition('flash');
      this.target_ATT.transition('flash');
    }
  });

  $('.ui.deep_confidence.dropdown').dropdown({
    onChange: function(value, text, $choice) {
      if (!this.target_G1 || !this.target_G2 || !this.target_G3 || !this.target_G4 || !this.target_G5 || !this.target_G6) {
        this.target_G1 = $('#' + $(this).data('target') + '_G1');
        this.target_G2 = $('#' + $(this).data('target') + '_G2');
        this.target_G3 = $('#' + $(this).data('target') + '_G3');
        this.target_G4 = $('#' + $(this).data('target') + '_G4');
        this.target_G5 = $('#' + $(this).data('target') + '_G5');
        this.target_G6 = $('#' + $(this).data('target') + '_G6');
      }
      document.cookie = "ci_level=" + text;
      value = value.split("_");
      this.target_G1.text(value[0]);
      this.target_G2.text(value[1]);
      this.target_G3.text(value[2]);
      this.target_G4.text(value[3]);
      this.target_G5.text(value[3]);
      this.target_G6.text(value[3]);
      this.target_G1.transition('flash');
      this.target_G2.transition('flash');
      this.target_G3.transition('flash');
      this.target_G4.transition('flash');
      this.target_G5.transition('flash');
      this.target_G6.transition('flash');
    }
  });

  $('.ui.form.evaluation-project')
    .form({
      fields: {
        'project[questionnaire_id]'       : 'empty',
        'project[questionnaire_language]' : 'empty',
        'project[product_type]'           : 'empty',
        'project[product_name]'           : 'empty',
        'project[project_code]'           : 'empty'
      }
    })
  ;

  $('.ui.form.attrakdiff')
    .form({
      fields: {
        'response_attrak_diff[QP1]' : 'checked',
        'response_attrak_diff[QP2]' : 'checked',
        'response_attrak_diff[QP3]' : 'checked',
        'response_attrak_diff[QP4]' : 'checked',
        'response_attrak_diff[QP5]' : 'checked',
        'response_attrak_diff[QP6]' : 'checked',
        'response_attrak_diff[QP7]' : 'checked',
        'response_attrak_diff[QHS1]' : 'checked',
        'response_attrak_diff[QHS2]' : 'checked',
        'response_attrak_diff[QHS3]' : 'checked',
        'response_attrak_diff[QHS4]' : 'checked',
        'response_attrak_diff[QHS5]' : 'checked',
        'response_attrak_diff[QHS6]' : 'checked',
        'response_attrak_diff[QHS7]' : 'checked',
        'response_attrak_diff[QHI1]' : 'checked',
        'response_attrak_diff[QHI2]' : 'checked',
        'response_attrak_diff[QHI3]' : 'checked',
        'response_attrak_diff[QHI4]' : 'checked',
        'response_attrak_diff[QHI5]' : 'checked',
        'response_attrak_diff[QHI6]' : 'checked',
        'response_attrak_diff[QHI7]' : 'checked',
        'response_attrak_diff[ATT1]' : 'checked',
        'response_attrak_diff[ATT2]' : 'checked',
        'response_attrak_diff[ATT3]' : 'checked',
        'response_attrak_diff[ATT4]' : 'checked',
        'response_attrak_diff[ATT5]' : 'checked',
        'response_attrak_diff[ATT6]' : 'checked',
        'response_attrak_diff[ATT7]' : 'checked'
      }
    })
  ;

  $('.ui.form.attrakdiffabridged')
    .form({
      fields: {
        'response_attrak_diff_abridged[QP2]' : 'checked',
        'response_attrak_diff_abridged[QP3]' : 'checked',
        'response_attrak_diff_abridged[QP5]' : 'checked',
        'response_attrak_diff_abridged[QP6]' : 'checked',
        'response_attrak_diff_abridged[QHS2]' : 'checked',
        'response_attrak_diff_abridged[QHS5]' : 'checked',
        'response_attrak_diff_abridged[QHI3]' : 'checked',
        'response_attrak_diff_abridged[QHI4]' : 'checked',
        'response_attrak_diff_abridged[ATT2]' : 'checked',
        'response_attrak_diff_abridged[ATT5]' : 'checked'
      }
    })
  ;

  $('.ui.form.sus')
    .form({
      fields: {
        'response_su[Q1]' : 'checked',
        'response_su[Q2]' : 'checked',
        'response_su[Q3]' : 'checked',
        'response_su[Q4]' : 'checked',
        'response_su[Q5]' : 'checked',
        'response_su[Q6]' : 'checked',
        'response_su[Q7]' : 'checked',
        'response_su[Q8]' : 'checked',
        'response_su[Q9]' : 'checked',
        'response_su[Q10]' : 'checked'
      }
    })
  ;

  $('.ui.form.deep')
    .form({
      fields: {
        'response_deep[Q1]' : 'checked',
        'response_deep[Q2]' : 'checked',
        'response_deep[Q3]' : 'checked',
        'response_deep[Q4]' : 'checked',
        'response_deep[Q5]' : 'checked',
        'response_deep[Q6]' : 'checked',
        'response_deep[Q7]' : 'checked',
        'response_deep[Q8]' : 'checked',
        'response_deep[Q9]' : 'checked',
        'response_deep[Q10]' : 'checked',
        'response_deep[Q11]' : 'checked',
        'response_deep[Q12]' : 'checked',
        'response_deep[Q13]' : 'checked',
        'response_deep[Q14]' : 'checked',
        'response_deep[Q15]' : 'checked',
        'response_deep[Q16]' : 'checked',
        'response_deep[Q17]' : 'checked',
        'response_deep[Q18]' : 'checked',
        'response_deep[Q19]' : 'checked'
      }
    })
  ;

  $('.ui.form.umux')
    .form({
      fields: {
        'response_umux[Q1]' : 'checked',
        'response_umux[Q2]' : 'checked',
        'response_umux[Q3]' : 'checked',
        'response_umux[Q4]' : 'checked'
      }
    })
  ;

  $('.ui.form.umuxlite')
    .form({
      fields: {
        'response_umux_lite[Q1]' : 'checked',
        'response_umux_lite[Q3]' : 'checked'
      }
    })
  ;

  // Show rich text editor (modal) and define actions
  var instructions_modal = $('#instructions_editor_modal').modal();

  $('a.show_editor_modal')
    .on('click', function(event) {
      event.preventDefault();
      instructions_modal.modal({inverted: true}).modal('show');
    });

  // Show help to choose which questionnaire does what (modal)
  var questionnaire_help_modal = $('#questionnaire_help_modal').modal({
    cancel  : '.cancel',
    approve  : '.approve'
  });

  $('a.show_questionnaire_help_modal')
    .on('click', function(event) {
      event.preventDefault();
      questionnaire_help_modal.modal({inverted: true}).modal('show');
    });

  // Show references of questionnaires (modal)
  var questionnaire_references_modal = $('#questionnaire_references_modal').modal({
    cancel  : '.cancel',
    approve  : '.approve'
  });
  $('a.show_questionnaire_references_modal')
    .on('click', function(event) {
      event.preventDefault();
      questionnaire_references_modal.modal({inverted: true}).modal('show');
    });

    /*
     * Navigable Tabs for form respondents
     *
     */
    $('.navigable-tabs').each(function () {
      var that = $(this),
          tabs = {
            count                     : that.find('.tab').length,
            main_form                 : that.find('.tab[data-tab|="main-form"]'),
            open_ended_questions      : that.find('.tab[data-tab|="open-ended-questions"]'),
            respondent_qualification  : that.find('.tab[data-tab|="respondent-qualification"]')
          },
          step_counter = {
            current_step  : that.find('.step-counter .current-step'),
            total_steps   : that.find('.step-counter .total-steps')
          },
          form = that.find('.ui.form'),
          active_tab = that.find('.active.tab');

      // Initialize steps counter
      step_counter.current_step.text("1");
      step_counter.total_steps.text(tabs.count);

      // Add a fake wait for loading
      that.tab({
        onVisible: function(tab) {
          var tab = $(this);
          active_tab = tab;
          setTimeout( function() {
            tab.removeClass('loading').addClass('transition fade in');
          }, 700);
        }
      });

      that.find('.button.to-open-ended-questions')
          .on('click', function() {
            active_tab.removeClass('transition fade in').addClass('loading ');
            $('html, body').animate({ scrollTop: 0 }, 500);
            setTimeout( function() {
              active_tab.removeClass('loading');
              if (active_tab.data('tab') == 'main-form') {
                form.form('validate form');
                if (form.form('is valid')) {
                  tabs.open_ended_questions.removeClass('transition fade in').addClass('loading');
                  that.tab('change tab', 'open-ended-questions').transition('fly left in');
                  step_counter.current_step.text("2");
                }
              } else {
                tabs.open_ended_questions.removeClass('transition fade in').addClass('loading');
                that.tab('change tab', 'open-ended-questions').transition('fly right in');
                step_counter.current_step.text("2");
              }
            }, 700);
          });

      that.find('.button.to-respondent-qualification')
          .on('click', function() {
            var form_type = form.data('formtype');
            active_tab.removeClass('transition fade in').addClass('loading ');
            $('html, body').animate({ scrollTop: 0 }, 500);
            setTimeout( function() {
              active_tab.removeClass('loading');
              if (active_tab.data('tab') == 'main-form') {
                form.form('validate form');
                if (form.form('is valid')) {
                  tabs.respondent_qualification.removeClass('transition fade in').addClass('loading');
                  that.tab('change tab', 'respondent-qualification').transition('fly left in');
                  step_counter.current_step.text("2");

                  // ADD RESPONDENT QUALIFICATION RULES
                  form.form('add rule', form_type + '[age]', 'integer[1..99]');
                  form.form('add rule', form_type + '[gender]', 'checked');
                  form.form('add rule', form_type + '[occupation]', 'empty');
                  // form.form('add rule', form_type + '[first_use_on]', 'empty');
                  // form.form('add rule', form_type + '[usage_frequency_per_month]', 'integer[1..99]');
                  // form.form('add rule', form_type + '[group]', 'integer[1..99]');

                }
              } else {
                tabs.respondent_qualification.removeClass('transition fade in').addClass('loading');
                that.tab('change tab', 'respondent-qualification').transition('fly left in');
                step_counter.current_step.text("3");

                // ADD RESPONDENT QUALIFICATION RULES
                //////////////////
                // Afficher les messages
                //////////////////
                form.form('add rule', form_type + '[age]', 'integer[1..99]');
                form.form('add rule', form_type + '[gender]', 'checked');
                form.form('add rule', form_type + '[occupation]', 'empty');
                // form.form('add rule', form_type + '[first_use_on]', 'empty');
                // form.form('add rule', form_type + '[usage_frequency_per_month]', 'integer[1..99]');
                // form.form('add rule', form_type + '[group]', 'integer[1..99]');
              }
            }, 700);
          });

      that.find('.button.to-main-form')
          .on('click', function() {
            var form_type = form.data('formtype');
            active_tab.removeClass('transition fade in').addClass('loading ');
            $('html, body').animate({ scrollTop: 0 }, 500);
            setTimeout( function() {
              active_tab.removeClass('loading');
              tabs.main_form.removeClass('transition fade in').addClass('loading');
              that.tab('change tab', 'main-form').transition('fly right in');
              step_counter.current_step.text("1");

              // REMOVE RESPONDENT QUALIFICATION RULES
              form.form('remove field', form_type + '[age]');
              form.form('remove field', form_type + '[gender]');
              form.form('remove field', form_type + '[occupation]');
              // form.form('remove field', form_type + '[first_use_on]');
              // form.form('remove field', form_type + '[usage_frequency_per_month]');
              // form.form('remove field', form_type + '[group]');

            }, 700);
          });
    });

});
