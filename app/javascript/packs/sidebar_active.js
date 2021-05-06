$('.nav-item').on('click', function () {
  $('li.active').removeClass('active');
  $(this).addClass('active');
});

$(() => {
  var pathname = document.location.pathname;
  $('.nav-item a').each(function () {
      var value = $(this).attr('href');
      if (pathname.indexOf(value) > -1) {
          $(this).closest('li').addClass('active');
          return false;
      }
  })
});
