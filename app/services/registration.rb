class Registration
  attr_reader :user

  def initialize(user_attributes:)
    @user = User.new(user_attributes)
  end

  def save
    user.budget_sheets.new(name: "Example Sheet", categories: categories)
    user.save
  end

  def error_message
    user.errors.full_messages.to_sentence
  end

  private

  def categories
    [
      Category.new(name: "Coffeehouse", budget_amount: 6500),
      Category.new(name: "Out to eat",  budget_amount: 26500),
      Category.new(name: "Datenight",   budget_amount: 12000)
    ]
  end
end
