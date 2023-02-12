class Ability
  include CanCan::Ability

  def initialize(user_or_admin)
    user_or_admin ||= User.new

    common_rules(user_or_admin)

    if user_or_admin.kind_of? Admin
      admin_rules(user_or_admin)
    else
      user_rules(user_or_admin)
    end
  end

  def common_rules(user_or_admin)
  end

  def admin_rules(admin)
    can :manage, Book
    can :manage, User
    can :manage, Review
  end

  def user_rules(user)
    can :read, Book
    can [:read, :create], Review
    can [:update, :delete], Review, user_id: user.id
  end
end