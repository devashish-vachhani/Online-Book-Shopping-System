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
    can :read, Book
    can :read, Review
  end

  def admin_rules(admin)
    can :manage, Book
    can :manage, User
    can :delete, Review
  end

  def user_rules(user)
    can :create, Review
    can [:update, :delete], Review, user_id: user.id
    can :manage, ShoppingCart
    can :manage, ShoppingCartItem
  end
end