class CategoryPolicy < ApplicationPolicy
  def create?
    record.budget_sheet.user_id == user.id
  end

  def update?
    record.budget_sheet.user_id == user.id
  end

  def destroy?
    record.budget_sheet.user_id == user.id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
