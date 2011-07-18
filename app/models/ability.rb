class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user 
    user.roles.each {|role| send(role) }
  end
  
  # Role Inheritance  
  def basic
    can :read, :all
    can :manage, Exercise
    can :manage, Workout
    can :manage, Activity
    can :manage, Goal
    can :manage, Result
  end
  def paid
    basic
    can :manage, Comment
  end
  def editor
    paid
    can :manage, Post
  end
  def admin
    editor
    can :access, :rails_admin
  end
end
