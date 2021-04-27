import {countDown} from './count_down'

$(() => {
  $('.exam-questions input').each(function() {
    $(this).attr('disabled', false);
  })
  }
);

$(() =>
  {
    let time = parseInt($('#time').val())
    if (time) countDown(time)
  }
);

$(() =>
  {
    $(window).on('blur', () => {
      $('form:first').submit()
    })
  }
)

$(() => {
  if (window.history && window.history.pushState) {
    $(window).on('popstate', function() {
      $('form:first').submit()
    });
  }
});
