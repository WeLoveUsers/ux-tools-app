$(document).on('turbo:load', function() {

  // Show terms (modal)
  var terms_modal = $('#terms_modal').modal({
    cancel  : '.cancel',
    approve  : '.approve',
    onApprove: function(what) {
      $('.ui.form.signup input#terms').prop('checked', true);
    }
  });
  $('a.show_terms_modal')
    .on('click', function(event) {
      event.preventDefault();
      terms_modal.modal({inverted: true}).modal('show');
    });

  $('.ui.form.password')
    .form({
      fields: {
        'user[email]'     : 'email'
      }
    })
  ;

  $('.ui.form.login')
    .form({
      fields: {
        'user[email]'     : 'email',
        'user[password]'  : 'empty'
      }
    })
  ;

  $('.ui.form.signup')
    .form({
      fields: {
        'user[email]'                 : 'email',
        'user[password]'              : 'minLength[6]',
        'user[password_confirmation]' : 'match[user[password]]',
        'terms'                       : 'checked'
      }
    })
  ;

});
