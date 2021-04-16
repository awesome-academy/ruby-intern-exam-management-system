class SessionsController < ApplicationController
  before_action :load_user_email, only: :create

  def new; end

  def create
    if @user.authenticate params[:session][:password]
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      flash[:success] = t("sessions.login_success")
      redirect_back_or root_path
    else
      login_failed
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  private

  def load_user_email
    @user = User.find_by email: params[:session][:email]
    return if @user

    login_failed
  end

  def login_failed
    flash[:danger] = t("sessions.login_failed")
    render :new
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete :forwarding_url
  end
end
