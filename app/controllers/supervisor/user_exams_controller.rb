class Supervisor::UserExamsController < SupervisorController
  before_action :load_trainee, only: :index

  def index
    @user_exams = @trainee.user_exams
                          .sort_by_created_at_desc
                          .includes({exam: :exam_questions}, :subject)
                          .paginate(page: params[:page])
                          .per_page(Settings.page)
  end

  private

  def load_trainee
    @trainee = User.find_by id: params[:trainee_id]
    return if @trainee

    flash[:danger] = t "trainees.not_found!"
    redirect_to root_path
  end
end
