class Supervisor::ExamsController < SupervisorController
  before_action :load_exam, only: :show

  def index
    @exams = Exam.sort_by_created_at_desc.includes(:subject)
                 .paginate(page: params[:page]).per_page(Settings.page)
  end

  def show
    @questions = Exam.questions_sort_by_created_at_asc(@exam).includes(:answers)
  end

  private

  def load_exam
    @exam = Exam.find_by(id: params[:id])
    return if @exam

    flash[:danger] = t("exams.not_found!")
    redirect_back(fallback_location: supervisor_exams_path)
  end
end
