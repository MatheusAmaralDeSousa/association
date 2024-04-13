class Person < ApplicationRecord
  belongs_to :user, optional: true

  before_save :update_amount

  has_many :debts, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :name, :national_id, presence: true
  validates :national_id, uniqueness: true
  validate :cpf_or_cnpj
  validate :valida_valor 
  after_save :amount

  # TODO: refactor me
  #
  # - improve performance using SQL
  # - sum payments
  # - rename to "balance"
  def total_debts
    debts_total = debts.sum(:amount)
    payments_total = payments.sum(:amount)

    debts_total -= payments_total
  end

  def update_amount
    amount = total_debts
    !save
  end
  private


  def cpf_or_cnpj
    if !CPF.valid?(national_id) && !CNPJ.valid?(national_id)
      errors.add :national_id, :invalid
    end
  end

  def valida_valor
    if payments.nil?
    end
  end
end
