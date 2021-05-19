# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user, namespace
    return unless user

    case namespace
    when Settings.namespace.trainee
      trainee(user) if user.trainee?
    when Settings.namespace.supervisor
      supervisor(user) if user.supervisor?
    end
  end

  def trainee user
    can :read, User, role: User.roles[:trainee]
    can :update, User, id: user.id
    can [:create, :read], UserExam, user_id: user.id
    can :update, UserExam, user_id: user.id, status: UserExam.statuses[:testing]
  end

  def supervisor user
    can :manage, :all
    cannot [:create, :update], UserExam
    cannot :update, User, role: User.roles[:supervisor]
    can :update, User, id: user.id
  end
end
