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
    # can :verb, :noun
  end

  def admin_rules(admin)
    can :manage, Book
    can :manage, User
  end

  def user_rules(user)
    can :read, Book
  end
end