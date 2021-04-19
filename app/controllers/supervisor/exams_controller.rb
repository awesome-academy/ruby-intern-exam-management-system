class Supervisor::ExamsController < SupervisorController
  def index
    @exams = Exam.sort_by_created_at_desc.includes(:subject)
                 .paginate(page: params[:page]).per_page(Settings.page)
  end
end
