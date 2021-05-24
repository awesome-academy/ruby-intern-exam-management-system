class Supervisor::UsersController < SupervisorController
  authorize_resource

  def trainees_index
    @q = User.ransack(params[:q])
    @trainees = @q.result.trainee.sort_by_created_at_desc
                  .includes(:user_exams)
                  .page(params[:page]).per_page(Settings.page)
  end

  def supervisors_index
    @q = User.ransack(params[:q])
    @supervisors = @q.result.supervisor.sort_by_created_at_desc
                     .page(params[:page]).per_page(Settings.page)
  end
end
