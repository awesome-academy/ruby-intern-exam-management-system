class Trainee::UserExamsController < TraineeController
  before_action :correct_user, only: %i(show update)
  before_action :check_user_exam_done?, only: :update
  before_action :load_subject, only: :create
  load_and_authorize_resource

  def index
    @subjects = Subject.sort_by_created_at_desc
    @user_exams = @user_exams.sort_by_created_at_desc
                             .includes({exam: :exam_questions}, :subject)
                             .paginate(page: params[:page])
                             .per_page(Settings.page)
  end

  def show
    begin
      @user_exam.testing! if @user_exam.start?
    rescue ActiveRecord::ActiveRecordError
      flash[:danger] = t("user_exams.try_again")
      redirect_to user_exams_path
    end
    @user_answer_ids = @user_exam.answers.pluck(:id)
  end

  def update
    save_and_mark_user_exam
    flash[:success] = t("user_exams.submit_success")
    redirect_to user_exams_path
  rescue ActiveRecord::ActiveRecordError
    flash[:danger] = t("user_exams.submit_failed")
    redirect_to user_exam_path(@user_exam)
  end

  def create
    user_exam = current_user.user_exams.build
    user_exam.exam = @subject.exams.sample
    if user_exam.save
      flash[:success] = t("user_exams.create_success!")
    else
      flash[:danger] = t("user_exams.create_failed!")
    end
    redirect_to user_exams_path
  end

  private

  def load_user_answer_ids
    @user_answer_ids = []
    questions_attributes = params[:user_exam][:questions_attributes]
    questions_attributes.each do |question_attributes|
      answers = question_attributes[1][:answers]
      @user_answer_ids << answers if answers.present?
    end
    @user_answer_ids.flatten!
  end

  def correct_user
    @user_exam = current_user.user_exams.find_by id: params[:id]
    return if @user_exam

    flash[:danger] = t("user_exams.not_found!")
    redirect_back(fallback_location: user_exams_path)
  end

  def check_user_exam_done?
    return if @user_exam.testing?

    flash[:danger] = t("user_exams.was_done")
    redirect_to user_exams_path
  end

  def load_subject
    @subject = Subject.find_by id: params[:subject].to_i
    return if @subject

    flash[:danger] = t("user_exams.create_failed!")
    redirect_to user_exams_path
  end

  def save_and_mark_user_exam
    UserExamAnswer.transaction do
      load_user_answer_ids
      @user_answer_ids.each do |id|
        user_exam_answer = @user_exam.user_exam_answers.build
        user_exam_answer.user_answer_id = id
        user_exam_answer.save!
      end
    end
    UserExam.transaction do
      @user_exam.spent_time = params[:user_exam][:spent_time]
      @user_exam.mark
      @user_exam.checked!
    end
  end
end
