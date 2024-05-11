class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dashboard_service

  def index
    @total_payments_ativos = @dashboard_service.total_payments_ativos
    @total_debts_ativos = @dashboard_service.total_debts_ativos
    @saldo = @dashboard_service.saldo
    @associado_maior_saldo = @dashboard_service.associado_maior_saldo
    @associado_menor_saldo = @dashboard_service.associado_menor_saldo
    @active_people_pie_chart = @dashboard_service.active_people_pie_chart
    @ultimos_lancamentos = @dashboard_service.ultimos_lancamentos
    @ultimos_cadastro_associados = @dashboard_service.ultimos_cadastro_associados || []
  end

  private

  def set_dashboard_service
    @dashboard_service = DashboardService.new
  end
end
