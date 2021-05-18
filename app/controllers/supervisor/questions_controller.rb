class Supervisor::QuestionsController < SupervisorController
  load_and_authorize_resource

  def index
    @questions = @questions.sort_by_created_at_desc
                           .paginate(page: params[:page])
                           .per_page(Settings.page)
  end
end
