class TraineeController < ApplicationController
  before_action :authenticate_user!

  private

  def current_ability
    @current_ability ||=
      Ability.new(current_user, Settings.namespace.trainee)
  end
end
