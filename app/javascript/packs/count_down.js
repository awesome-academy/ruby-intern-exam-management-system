export function countDown(time) {
  var countDownDate = new Date();
  countDownDate.setMinutes(countDownDate.getMinutes() + time)
  var x = setInterval(() => {
    var now = new Date().getTime();
    var distance = countDownDate.getTime() - now;

    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    var seconds = Math.floor((distance % (1000 * 60)) / 1000);

    $('#hours').text(hours)
    $('#minutes').text(minutes)
    $('#seconds').text(seconds)

    $('#user_exam_spent_time').val(time * 60 - (hours * 3600 + minutes * 60 + seconds))
    if (distance <= 0) {
      alert(I18n.t("user_exams.time_for_test_out"))
      clearInterval(x);
      $('form:first').submit()
    }
  }, 1000);
}
