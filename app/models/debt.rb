class Debt < ApplicationRecord
  belongs_to :person

  validates :amount, presence: true
  after_save :update_amount

  def update_amount
    Person.total_debts
    Person.save
  end
end
