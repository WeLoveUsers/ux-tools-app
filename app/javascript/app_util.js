$(document).on('turbo:load', function() {

  $('.ui.calendar.date').calendar({
    silent: false,
    debug: true,
    type: 'date',
    firstDayOfWeek: 1,
    monthFirst: true,
    text: {
      days: ['L', 'M', 'M', 'J', 'V', 'S', 'D'],
      months: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
      monthsShort: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jui', 'Jul', 'Aou', 'Sep', 'Oct', 'Nov', 'Dec'],
      today: "Aujourd'hui",
      now: 'Maintenant',
      am: 'AM',
      pm: 'PM'
    },
    onChange: function (date, text) {
      if (date === undefined || date === null) {
        $(this).next("input[type='hidden']").val('');
      } else {
        $(this).next("input[type='hidden']").val(date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear());
      }
    }
  });

  // Sets new settings for calendars with a minimum date :
  // Structure :
  //    <div class="ui calendar date with-min-date"
  //         data-min-date="2018-12-25"
  //         data-set-date=""   [OR]    data-set-date="2019-01-10"
  //    </div>
  $('.ui.calendar.date.with-min-date').each(function () {
    var cal = $(this),
        minDate = new Date(cal.data('min-date')),
        setDate = false;
    if (cal.data('set-date') != '') {
      setDate = new Date(cal.data('set-date'));
    }
    cal.calendar('setting', 'minDate', minDate)
       .calendar('changeDate', setDate);
  });

  $('.ui.calendar.date.month').each(function () {
    $(this).calendar('setting','type', 'month');
  });




  $('.ui.calendar.date .clear-date.button')
    .on('click', function() {
      if (!this.calendar) {
        this.calendar = $(this).parent().parent();
      }
      this.calendar.calendar('clear');
      this.calendar.calendar('blur');
    });

  $('.ui.pointing.menu .item').tab();
  $('.ui.form select').dropdown();
  $('.ui.checkbox:not(#show_variability)').checkbox();
  $('.popup').popup({
    offset: -13
  });

  $('.ui.config.button').popup({
    inline: true,
    position: 'bottom right',
    on: 'click',
    variation: "wide"
  });

  $('.message .close')
    .on('click', function() {
      $(this)
        .closest('.message')
        .transition('fade')
      ;
    });

    $('form input.field-popup')
      .popup({
        on: 'focus'
      });

    /*
     * Bouton pour le dropdown de l'utilisateur connecté
     */
    var user_popup = $('.ui.item.user_account').popup({
        inline: true,
        position: 'bottom right',
        on: 'click',
        variation: "wide"
    });

  /*
   * Bouton pour le dropdown des notifications
   */
  var shoud_close_notifications_popup = true;
  var notifications_popup = $('.ui.item.notifications').popup({
      inline: true,
      position: 'bottom right',
      on: 'click',
      variation: "wide",
      onHide: function(a, b, c) {
        if (!shoud_close_notifications_popup) {
          return false;
        }
      }
  });
  /*
   * Modal pour le détail des notifications
   */
  var app_notifications_count = $('#app_notifications_count');
  $('.app_notifications .ui.notification.preview').each(function(){
    var e = $(this);
    var notification_details = e.find('.ui.modal').modal({
      approve  : '.approve',
      cancel   : '.cancel',
      inverted: true,
      onApprove: function(){
      },
      onHidden: function($element) {
        shoud_close_notifications_popup = true;
      }
    });
    var mark_notification_as_read_url = e.data('read-url');
    e.on('click', function(event) {
      //Force popup to remain visible
      shoud_close_notifications_popup = false;

      //Marks as read
      if (!e.hasClass('read')) {
//@TODO ---------------------------------------------- Afficher un spinner ?
        $.get(mark_notification_as_read_url, function(data) {
          //console.log(data);
          e.addClass('read');
          new_count = app_notifications_count.text() - 1;
          app_notifications_count.text(new_count);
          if (new_count == 0) {
            app_notifications_count.addClass('read');
          }
        }).fail(function() {
          //alert( "Hummm... il y a un petit problème avec notre application. Pourriez-vous nous en informer " );
        });
      }

      //Displays the details
      notification_details.modal('show');
    });
  });

  /*
   * Recherche "data-modalconfirm" pour afficher une fenêtre modal de confirmation
   */
  $('input[data-modalconfirm]').each(function(){
    var e = $(this);
    var message = e.data('modalconfirm');
    var form = e.parent('form');
    var confirmationModal = $('<div class="ui small modal"><div class="header">Confirmation</div><div class="content">' + message + '</div><div class="actions"><div class="ui cancel inverted button">Annuler</div><div class="ui approve button">Confirmer</div></div></div>');
    form.append(confirmationModal);
    form.confirmed = false;
    var modal = confirmationModal.modal({
      approve  : '.approve',
      cancel   : '.cancel',
      inverted: true,
      onApprove: function(){
        form.confirmed = true;
        form.submit();
      }
    });
    form.on('submit', function(event) {
      if (form.confirmed) {
        return true;
      } else {
        modal.modal('show');
        event.preventDefault();
      }
    });
  });

});
