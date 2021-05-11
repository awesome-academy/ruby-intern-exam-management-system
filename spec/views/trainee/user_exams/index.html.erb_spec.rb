require "rails_helper"

RSpec.describe "trainee/user_exams/index", type: :view do
  let!(:user_exams) { create(:user_with_user_exams, user_exams_count: 1).user_exams }
  let!(:subjects) { Subject.all }

  before(:each) do
    assign :subjects, subjects
  end

  it "renders correctly with list of subject's name" do
    render

    expect(rendered).to have_content subjects.first.name
  end

  it "renders correctly with list of user_exam's spent_time" do
    assign :user_exams, user_exams
    allow(view).to receive(:convert_num_to_time)
                   .with(user_exams.first.spent_time).and_return "00:00:00"

    render

    expect(rendered).to have_content "00:00:00"
  end
end
