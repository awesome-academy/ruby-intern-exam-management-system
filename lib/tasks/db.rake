desc "Cleanup duplicated records of user_exam_statistic"
task cleanup_statistics_duplicated: :environment do
  dates = UserExamStatistic.distinct.pluck :date
  dates.each do |date|
    statistics = UserExamStatistic.statistic_on_date(date).to_a
    next unless statistics.size > 1

    statistics.pop
    statistics.each do |statistic|
      UserExamStatistic.transaction do
        statistic.user_exam_statistic_details.each(&:destroy!)
        statistic.destroy!
      end
    rescue ActiveRecord::ActiveRecordError
      puts "Having an error with record has id: #{statistic.id}"
    end
  end
end

desc "Statistic missed user_exam-statistic"
task statistic_miss_days: :environment do
  beginning_date = DateTime.now.beginning_of_month
  end_date = DateTime.now.end_of_month
  (beginning_date..end_date).each do |date|
    size = UserExamStatistic.statistic_on_date(date).size
    UserExamStatisticJob.perform_later(date) if size.zero?
  end
end
