class SubscriptionController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:new, :create, :update]

  def new

  end

  def create
    byebug
  end

  private
  def set_plan
    @plan = Plan.find_by(id: params[:plan_id])

    redirect_to pricing_path if @plan.nil?
  end
end
