# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user

  def active?
    %w[trialing active].include?(status) && (ends_at.nil? || on_grace_period? || on_trial?)
  end

  def on_grace_period?
    canceled? && Time.zone.now < ends_at
  end

  def canceled?
    ends_at?
  end

  def on_trial?
    trial_ends_at? && Time.zone.now < trial_ends_at
  end

  def has_incomplete_payment?
    %w[past_due incomplete].include?(status)
  end

  def swap(plan)
    stripe_sub = stripe_subscription
    subscription = Stripe::Subscription.update(stripe_id,
                                               cancel_at_period_end: false,
                                               items: [
                                                 {
                                                   id: stripe_subscription.items.data[0].id,
                                                   plan: plan
                                                 }
                                               ])
    update(stripe_plan: plan, ends_at: nil)
  end

  def stripe_subscription
    Stripe::Subscription.retrieve(stripe_id)
  end
end
