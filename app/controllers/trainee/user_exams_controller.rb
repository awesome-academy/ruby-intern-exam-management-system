class Trainee::UserExamsController < TraineeController
  def index
    @exams = Exam.sort_by_created_at_desc
    @user_exams = current_user.user_exams
                              .sort_by_created_at_desc.includes(exam: :subject)
                              .paginate(page: params[:page])
                              .per_page(Settings.page)
  end
end
