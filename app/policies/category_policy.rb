class CategoryPolicy < ApplicationPolicy
  def create?
    User.joins(:budget_sheets)
      .where(budget_sheets: { id: record.budget_sheet })
      .where(id: user.id)
      .exists?
  end

  def update?
    category_budget_sheet_belongs_to_user?
  end

  def destroy?
    category_budget_sheet_belongs_to_user?
  end

  private

  def category_budget_sheet_belongs_to_user?
    User.joins(budget_sheets: :categories)
      .where(categories: { id: record.id })
      .where(id: user.id)
      .exists?
  end
end
