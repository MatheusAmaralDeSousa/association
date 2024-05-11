class DashboardService
  
    def total_associados
      Rails.cache.fetch('total_associados', expires_in: 1.day) do
        {
          active: Person.where(active: true).count,
          inactive: Person.where(active: false).count
        }
      end
    end
  
    def total_debts_ativos
      Rails.cache.fetch('total_debts_ativos', expires_in: 1.day) do
        # Total somando todos associados ativos
        active_people_ids = Person.where(active: true).select(:id)
        Debt.where(person_id: active_people_ids).sum(:amount)
      end
    end
  
    def total_payments_ativos
      Rails.cache.fetch('total_payments_ativos', expires_in: 1.day) do
        active_people_ids = Person.where(active: true).select(:id)
        Payment.where(person_id: active_people_ids).sum(:amount)
      end
    end
  
    def ultimos_lancamentos
      Rails.cache.fetch('ultimos_lancamentos', expires_in: 1.hour) do
        # últimos lançamentos
        # no formato somente id + amount para o kickchart
        debts = Debt.order(created_at: :desc).limit(10).map { |debt| [debt.id, debt.amount] }
        payments = Payment.order(created_at: :desc).limit(10).map { |payment| [payment.id, payment.amount] }
        { debts: debts, payments: payments }
      end
    end
  
    def ultimos_cadastro_associados
      Rails.cache.fetch('ultimos_cadastro_associados', expires_in: 1.day) do
        # últimos associados cadastrados pelo usuário atual
        Person.where(user: current_user).order(:created_at).limit(10)
      end
    end
  
    def associado_maior_saldo
      Rails.cache.fetch('associado_maior_saldo', expires_in: 1.day) do
        # Encontra a pessoa com o maior saldo diretamente no banco de dados
        Person.where('amount > 0').order(amount: :desc).first
      end
    end
  
    def associado_menor_saldo
      Rails.cache.fetch('associado_menor_saldo', expires_in: 1.day) do
        # Encontra a pessoa com o menor saldo diretamente no banco de dados
        Person.where('amount > 0').order(amount: :asc).first
      end
    end
  end
  