$(document).on('turbo:load', function() {
  $('body.response:not(.public) .deep-grid .section.header')
    .visibility({
      type   : 'fixed',
      offset : 51
    })
  ;
  $('body.response.public .deep-grid .section.header')
    .visibility({
      type   : 'fixed',
      offset : 0
    })
  ;
});
