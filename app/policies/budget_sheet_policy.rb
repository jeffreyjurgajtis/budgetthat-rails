class BudgetSheetPolicy < ApplicationPolicy
  def index?
    belongs_to_user?
  end

  def create?
    belongs_to_user?
  end

  def show?
    belongs_to_user?
  end

  def update?
    belongs_to_user?
  end

  def destroy?
    belongs_to_user?
  end

  private

  def belongs_to_user?
    record.user_id == user.id
  end
end
