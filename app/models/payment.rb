class Payment < ApplicationRecord
  belongs_to :person

  after_save :update_amount

  def update_amount
    Person.total_debts
    Person.save
  end
end
