class FileService
  class << self
    def read_questions_from_file! file_path, subject
      xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
      ActiveRecord::Base.transaction do
        xlsx.last_row.times.each do |n|
          save_row(xlsx.row(n + 1).compact, subject)
        end
      end
    end

    private

    def save_row row, subject
      correct_answer = row.pop.to_s.split(/,/)
      choice_type = Question.choice_types[:single]
      choice_type = Question.choice_types[:multiple] if correct_answer.size > 1
      question = Question.create!(
        content: row.shift,
        subject: subject,
        choice_type: choice_type
      )
      row.each_with_index do |content, index|
        Answer.create!(
          content: content,
          question: question,
          correct: correct_answer.include?((index + 1).to_s)
        )
      end
    end
  end
end
