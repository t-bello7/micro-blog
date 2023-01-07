class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :destroy, Post if user.is? 'admin'
    can :destroy, Commnet if user.is? 'admin'
  end
end
