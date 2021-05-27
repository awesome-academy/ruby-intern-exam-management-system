require "rails_helper"

RSpec.describe Supervisor::QuestionsController, type: :controller do
  let!(:user) { create(:supervisor_user) }
  before(:each) do
    sign_in user
  end

  describe "GET #index" do
    let!(:subject) { create(:create_subject_with_questions_list) }
    let!(:questions) { Question.all }

    before(:each) do
      get :index
    end

    it "gets all questions" do
      expect(assigns(:questions)).to match_array questions
    end

    it "renders index view" do
      expect(response).to render_template "index"
    end
  end

  describe "GET #new_list" do
    let!(:subjects) { create_list(:subject, 10) }

    before(:each) do
      get :new_list
    end

    it "gets all subjects" do
      expect(assigns(:subjects)).to match_array subjects
    end

    it "renders new list view" do
      expect(response).to render_template "new_list"
    end
  end

  describe "POST #create_list" do
    let!(:subjects) { create_list(:subject, 3) }

    context "subject not found" do
      before(:each) do
        post :create_list, params: { subject: -1 }
      end

      it "redirects to new_list_questions_path" do
        expect(:response).to redirect_to new_list_questions_path
      end

      it "flash danger with choice_subject message" do
        expect(flash[:danger]).to eq I18n.t("questions.choice_subject!")
      end
    end

    context "file not found" do
      before(:each) do
        post :create_list, params: { subject: Subject.first.id, file: {} }
      end

      it "redirects to new_list_questions_path" do
        expect(:response).to redirect_to new_list_questions_path
      end

      it "flash danger with please_choice_file message" do
        expect(flash[:danger]).to eq I18n.t("questions.please_choice_file!")
      end
    end

    context "file type is uncorrect" do
      before(:each) do
        @file = fixture_file_upload("questions.txt")
        post :create_list, params:{file: @file ,subject: Subject.first.id}
      end

      it "redirects to new_list_questions_path" do
        expect(:response).to redirect_to new_list_questions_path
      end

      it "flash danger with please_choice_correct_file_type message" do
        expect(flash[:danger]).to eq I18n.t("questions.please_choice_correct_file_type!")
      end
    end

    context "create list questions fail" do
      before(:each) do
        @file = fixture_file_upload("questions.xls")
        FileService.stub(:save_row).and_raise ActiveRecord::ActiveRecordError
        post :create_list, params:{file: @file ,subject: Subject.first.id}
      end

      it "redirects to new_list_questions_path" do
        expect(:response).to redirect_to new_list_questions_path
      end

      it "flash danger with create_list_fail message" do
        expect(flash[:danger]).to eq I18n.t("questions.create_list_fail")
      end
    end

    context "create questions list success" do
      before(:each) do
        @file = fixture_file_upload("questions.xls")
        post :create_list, params:{file: @file ,subject: Subject.first.id}
      end

      it "redirects to questions_path" do
        expect(:response).to redirect_to questions_path
      end

      it "flash success with create_list_success message" do
        expect(flash[:success]).to eq I18n.t("questions.create_list_success")
      end
    end
  end
end
