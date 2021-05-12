require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { create :user }

  describe "Associations" do
    it { is_expected.to have_many(:user_exams).dependent :destroy }
  end

  describe "Validations" do
    context "validates password attribute" do
      it { expect(User.new).to validate_presence_of :password }
      it { is_expected.to have_secure_password }
      it { is_expected.to validate_length_of :password }
    end

    context "validates name attribute" do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_length_of :name }
    end

    context "validates email attribute" do
      it { is_expected.to validate_presence_of :email }
      it { is_expected.to validate_length_of :email }
      it { is_expected.to allow_value("dhh@nonopinionated.com").for :email }
      it { is_expected.to_not allow_value("base@example").for :email }
      it { is_expected.to_not allow_value("blah").for :email }
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end
  end

  describe "Public instance methods" do
    context "responds to its methods" do
      it { is_expected.to respond_to :remember }
      it { is_expected.to respond_to :authenticated? }
      it { is_expected.to respond_to :forget }
    end

    context "method #remember" do
      it "returns true" do
        expect(user.remember).to be true
      end
    end

    context "method #forget" do
      it "returns true" do
        expect(user.forget).to be true
      end
    end

    context "method #authenticated?" do
      it "returns true when correct token" do
        token = User.new_token
        remember_token = User.digest token
        user.update_column :remember_digest, remember_token

        expect(user.authenticated?(:remember, token)).to be true
      end

      it "returns false when uncorrect token" do
        remember_token = User.digest User.new_token
        user.update_column :remember_digest, remember_token

        expect(user.authenticated?(:remember, "unkown")).to be false
      end

      it "returns false when digest for token is nil" do
        expect(user.authenticated?(:remember, "unknown")).to be false
      end
    end
  end

  describe "Public class methods" do
    subject { User }

    context "responds to its methods" do
      it { is_expected.to respond_to :new_token }
      it { is_expected.to respond_to :digest }
    end

    context "method .new_token" do
      it "returns a token with length is 22" do
        expect(subject.new_token.size).to eq 22
      end
    end

    context "method .digest" do
      it "returns a digest with length is 60 when min_cost is present " do
        ActiveModel::SecurePassword.min_cost = 10

        expect(subject.digest(subject.new_token).size).to eq 60
      end

      it "returns a digest with length is 60 when min_cost is nil " do
        ActiveModel::SecurePassword.min_cost = nil

        expect(subject.digest(subject.new_token).size).to eq 60
      end
    end
  end
end
