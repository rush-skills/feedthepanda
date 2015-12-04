class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    if user and user.is_admin?
        can :access, :rails_admin   # grant access to rails_admin
        can :dashboard              # grant access to the dashboard
        can :read, [Post, Subscription, Channel]
        # can :read, Post do |object|
        #     object.can_read(user)
        # end
        can [:edit], [Channel] do |object|
            object.is_admin(user)
        end
        can [:create, :edit], [Post] do |object|
            object.channel.is_admin(user)
        end
        can [:toggle], [Subscription] do |object|
            object.channel.is_admin(user)
        end
        if user.admin
            can [:read, :edit, :create], [Channel, ChannelAdmin]
            can [:read, :edit], Post
            can :toggle, :channel
        end
        if user.superadmin
            can :manage, :all
            can :history, :all
            can :toggle, :all
        end
    end
  end
end
