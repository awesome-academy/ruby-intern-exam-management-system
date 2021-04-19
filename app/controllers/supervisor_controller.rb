class SupervisorController < ApplicationController
  before_action :logged_in_user, :require_supervisor

  private

  def require_supervisor
    return if current_user.supervisor?

    flash[:danger] = t("access_denied!")
    redirect_to root_path
  end
end
