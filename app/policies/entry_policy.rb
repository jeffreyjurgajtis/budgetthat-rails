class EntryPolicy < ApplicationPolicy
  def update?
    record.category.budget_sheet.user_id == user.id
  end

  def destroy?
    record.category.budget_sheet.user_id == user.id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
