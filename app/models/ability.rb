class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    ##
    # A user can only manage their collections
    can :manage, Collection, user_id: user.id
    can :manage, Manifest, user_id: user.id
    can :manage, Workspace, user_id: user.id
    can :manage, Annotation do |annotation|
      can? :manage, annotation.workspace
    end
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
