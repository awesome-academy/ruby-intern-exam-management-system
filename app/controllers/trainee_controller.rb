class TraineeController < ApplicationController
  before_action :logged_in_user, :require_trainee

  def require_trainee
    return if current_user.trainee?

    flash[:danger] = t("access_denied!")
    redirect_to root_path
  end
end
