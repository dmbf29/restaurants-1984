class RestaurantPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # basically saying Restaurant.all
      scope.all
      # for a rentals/bookings index
      # scope.where(user: user)
      # user.restaurants
    end
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    # user (aka current_user)
    # record (the thing you authorized)
    record.user == user || user&.admin?
  end

  def update?
    record.user == user || user&.admin?
  end

  def destroy?
    record.user == user || user&.admin?
  end
end
