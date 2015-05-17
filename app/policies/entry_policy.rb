class EntryPolicy < ApplicationPolicy
  def create?
    User.joins(budget_sheets: :categories)
      .where(categories: { id: record.category_id })
      .where(id: user.id)
      .exists?
  end

  def update?
    budget_sheet_belongs_to_user?
  end

  def destroy?
    budget_sheet_belongs_to_user?
  end

  private

  def budget_sheet_belongs_to_user?
    User.joins(budget_sheets: { categories: :entries })
      .where(entries: { id: record.id })
      .where(id: user.id)
      .exists?
  end
end
