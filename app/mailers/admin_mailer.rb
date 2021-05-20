class AdminMailer < ApplicationMailer
  default to: ->{User.supervisor.pluck(:email)}

  def statistic_done_user_exams datetime
    @statistic = UserExamStatistic.find_by("date(date) = date('#{datetime}')")
    return unless @statistic

    @statistic_detail = @statistic.user_exam_statistic_details.includes :subject
    I18n.with_locale(I18n.locale) do
      mail subject: t("admin_mailer.subjects.exam_statistic")
    end
  end
end
