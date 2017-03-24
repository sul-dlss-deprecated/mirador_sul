class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    ##
    # A user can only manage their collections
    can :manage, Collection, user_id: user.id
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
