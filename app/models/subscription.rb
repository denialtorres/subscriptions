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

  def cancel
    subscription = Stripe::Subscription.update(stripe_id,{ cancel_at_period_end: true })
    update(ends_at: Time.at(subscription.cancel_at))
  end

  def cancel_now!
    subscription = Stripe::Subscription.delete(stripe_id)
    update(status: 'canceled', ends_at: Time.at(subscription.ended_at))
  end

  def resume
    if Time.current < ends_at
      Stripe::Subscription.update(stripe_id,{ cancel_at_period_end: false })
      update(status: 'active', ends_at: nil)
    else
      raise StandardError, "You Cannot Resume a subscription that has already been canceled"
    end
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
