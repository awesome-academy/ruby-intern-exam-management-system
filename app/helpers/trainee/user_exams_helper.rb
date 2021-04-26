module Trainee::UserExamsHelper
  def convert_num_to_time spent_time
    h = spent_time / 3600
    spent_time %= 3600
    m = spent_time / 60
    s = spent_time % 60
    %(#{two_number(h)}:#{two_number(m)}:#{two_number(s)})
  end

  private

  def two_number num
    (0..9).include?(num) ? %(0#{num}) : num
  end
end
