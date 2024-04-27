class Payment < ApplicationRecord
  belongs_to :person

  after_save :update_amount

  def update_amount
    person.update_amount
    person.save
  end
end
