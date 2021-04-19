class Supervisor::QuestionsController < SupervisorController
  def index
    @questions = Question.sort_by_created_at_desc.paginate(page: params[:page])
                         .per_page(Settings.page)
  end
end
