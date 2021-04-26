module Trainee::UserExamsHelper
  def convert_num_to_time spent_time
    h = spent_time / 3600
    spent_time %= 3600
    m = spent_time / 60
    s = spent_time % 60
    %(#{two_number(h)}:#{two_number(m)}:#{two_number(s)})
  end

  def exam_options exams
    exams.map{|u| [u.name, u.id]}
  end

  def class_for_user_exam_status user_exam
    return "label label-primary" if user_exam.start?
    return "label label-info" if user_exam.unchecked?
    return "label label-success" if user_exam.checked?

    "label label-danger"
  end

  private

  def two_number num
    (0..9).include?(num) ? %(0#{num}) : num
  end
end
