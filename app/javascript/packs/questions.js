$(function() {
  var counter = 1;
  var current_page = $('ul.pagination li.active a')[0].innerText
  $('ol.quiz li').each(function(){
    $this = $(this);
    $this.attr('counter', (parseInt(current_page) - 1) * 20 + counter);
    counter++;
  });
});
