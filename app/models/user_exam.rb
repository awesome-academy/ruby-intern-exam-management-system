class UserExam < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  enum status: {start: 0, unchecked: 1, checked: 2, testing: 3}
  scope :sort_by_created_at_desc, ->{order created_at: :desc}
  scope :done_on_date, (lambda do |date|
    where "date(user_exams.updated_at) = date('#{date}')"
  end)
  has_one :subject, through: :exam
  has_many :questions, through: :exam
  has_many :user_exam_answers, dependent: :destroy
  has_many :answers, through: :user_exam_answers
  has_many :exam_questions, through: :exam
  accepts_nested_attributes_for :questions

  def mark
    self.exam_questions = exam_questions.includes :question, :answers
    self.total_score = exam_questions.reduce(0) do |total, exam_question|
      @exam_question = exam_question
      total + mark_of_question
    end
  end

  private

  def mark_of_question
    if @exam_question.question.single?
      mark_of_single_ans_question
    else
      mark_of_multi_ans_question
    end
  end

  def mark_of_single_ans_question
    user_exam_answers.each do |user_exam_answer|
      return @exam_question.score if check_answer_correct user_exam_answer
    end
    0
  end

  def mark_of_multi_ans_question
    correct_answers = @exam_question.answers.select(&:correct?)
    return @exam_question.score if correct_answers.count.zero?

    @mark_each_correct_answer = @exam_question.score / correct_answers.count
    add_mark_when_ans_correct
    sub_mark_when_ans_uncorrect
    @score
  end

  def add_mark_when_ans_correct
    @score = user_exam_answers.reduce(0) do |plus_mark, user_exam_answer|
      if check_answer_correct user_exam_answer
        plus_mark + @mark_each_correct_answer
      else
        plus_mark
      end
    end
  end

  def sub_mark_when_ans_uncorrect
    @score = user_exam_answers.reduce(@score) do |sub_mark, user_exam_answer|
      if check_answer_uncorrect(user_exam_answer) && sub_mark.positive?
        sub_mark - @mark_each_correct_answer
      else
        sub_mark
      end
    end
  end

  def check_answer_correct user_exam_answer
    @exam_question.answers.include?(user_exam_answer.answer) &&
      user_exam_answer.correct
  end

  def check_answer_uncorrect user_exam_answer
    @exam_question.answers.include?(user_exam_answer.answer) &&
      !user_exam_answer.correct
  end
end
