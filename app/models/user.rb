class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
  enum role: {supervisor: 1, trainee: 2}
  attr_accessor :remember_token
  before_save ->{email.downcase!}
  validates :name, presence: true,
            length: {maximum: Settings.user.name.max_length}
  validates :email, presence: true, uniqueness: true,
            length: {maximum: Settings.user.email.max_length},
            format: {with: Settings.user.email.regex}
  validates :password, presence: true,
            length: {minimum: Settings.user.password.min_length}
  has_many :user_exams, dependent: :destroy

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_column :remember_digest, nil
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end
  end
end
