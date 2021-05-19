class SupervisorController < ApplicationController
  before_action :authenticate_user!

  private

  def current_ability
    @current_ability ||=
      Ability.new(current_user, Settings.namespace.supervisor)
  end
end
