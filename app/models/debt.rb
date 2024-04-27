class Debt < ApplicationRecord
  belongs_to :person

  validates :amount, presence: true
  after_save :update_amount

  def update_amount
    person.update_amount
    person.save
  end
end
