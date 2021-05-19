require "rails_helper"

RSpec.describe Trainee::UserExamsController, type: :controller do
  let!(:user) { create(:user_with_user_exams) }
  let(:user_exams) { user.user_exams }
  before(:each) do
    sign_in user
  end

  describe "GET #index" do
    before(:each) do
      get :index
    end

    it "gets all user's exams" do
      expect(assigns(:user_exams)).to match_array user_exams
    end

    it "gets all subjects" do
      expect(assigns(:subjects)).to match_array Subject.all
    end

    it "renders index view" do
      expect(response).to render_template "index"
    end
  end

  describe "GET #show" do
    context "user exam is present" do
      it "renders show view" do
        get :show, params: {id: user.user_exams.first}

        expect(response).to render_template "show"
      end

      it "redirects to user_exams_path when changing status fail" do
        allow(controller).to receive(:correct_user)
        user_exam = user_exams.first
        user_exam.exam_id = -1
        controller.instance_variable_set(:@user_exam, user_exam)

        get :show, params: {id: user_exam}

        expect(response).to  redirect_to user_exams_path
      end

      it "flash danger with try_again message when changing status fail" do
        allow(controller).to receive(:correct_user)
        user_exam = user_exams.first
        user_exam.exam_id = -1
        controller.instance_variable_set(:@user_exam, user_exam)

        get :show, params: {id: user_exam}

        expect(flash[:danger]).to eq I18n.t("user_exams.try_again")
      end
    end
  end

  describe "POST #update" do
    context "user_exam was done" do
      before do
        user_exams.first.checked!

        post :update, params: {id: user_exams.first}
      end

      it "redirects to user_exams_path when user_exam was done" do
        expect(response).to redirect_to user_exams_path
      end

      it "flash danger with create_failed message when user_exam was done" do
        expect(flash[:danger]).to eq I18n.t("user_exams.was_done")
      end
    end

    context "submits user_exam successful" do
      before do
        allow(controller).to receive(:check_user_exam_done?)
        allow(controller).to receive(:save_and_mark_user_exam)
        user_exams.first.testing!

        post :update, params: {id: user_exams.first}
      end

      it "redirects to user_exams_path" do
        expect(response).to redirect_to user_exams_path
      end

      it "flash success with submit_success message" do
        expect(flash[:success]).to eq I18n.t("user_exams.submit_success")
      end
    end

    context "updates user_exams fail" do
      before do
        allow(controller).to receive(:check_user_exam_done?)
        allow(controller).to receive(:save_and_mark_user_exam).and_raise ActiveRecord::ActiveRecordError
        user_exams.first.testing!

        post :update, params: {id: user_exams.first}
      end

      it "redirects to user_exam_path(@user_exam)" do
        expect(response).to redirect_to user_exam_path(assigns(:user_exam))
      end

      it "flash danger with submit_failed message" do
        expect(flash[:danger]).to eq I18n.t("user_exams.submit_failed")
      end
    end
  end

  describe "POST #create" do
    context "subject is not found" do
      before do
        post :create, params: {subject: -1}
      end

      it "redirects to user_exams_path" do
        expect(:response).to redirect_to user_exams_path
      end

      it "flash danger with create_failed message" do
        expect(flash[:danger]).to eq I18n.t("user_exams.create_failed!")
      end
    end

    context "user_exam is present" do
      it "flash danger with create_failed message when create successful" do
        post :create, params: {subject: Subject.first}

        expect(flash[:success]).to eq I18n.t("user_exams.create_success!")
      end

      it "flash danger with create_failed message when create fail" do
        allow(controller).to receive(:load_subject)
        controller.instance_variable_set(:@subject, create(:subject))

        post :create, params: {subject: Subject.first}

        expect(flash[:danger]).to eq I18n.t("user_exams.create_failed!")
      end

      it "redirects user_exams_path after save" do
        post :create, params: {subject: Subject.first}

        expect(:response).to redirect_to user_exams_path
      end
    end
  end
end
