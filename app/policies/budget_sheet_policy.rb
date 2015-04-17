class BudgetSheetPolicy < ApplicationPolicy
  def show?
    record.user_id == user.id
  end

  def update?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
