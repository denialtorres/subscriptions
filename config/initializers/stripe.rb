Stripe.api_key = "sk_test_51JL1YiAQK64ZnDfYWcA38VzkYD08j0dm151rQLjJGn08EMxlTnVo5fS5iEjcN6caEWLzYy0xtjvnPsKPXRcw4iCo00Lg14vTKp"

class PaymentIncomplete < StandardError
  attr_reader :payment_intent

  def initialize(payment_intent)
    @payment_intent = payment_intent
  end
end

StripeEvent.signing_secret = 'whsec_z6MwgAHWRuHzyYBjHCMnlkHgktXQIxBa'

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', ChargeSucceededWebhook.new
  events.subscribe 'charge.refunded', ChargeRefundedWebhook.new
  events.subscribe 'customer.subscription.updated', SubscriptionUpdatedWebhook.new
  events.subscribe 'customer.subscription.deleted', SubscriptionDeletedWebhook.new
  events.subscribe 'invoice.payment_action_required', PaymentActionRequiredWebhook.new
end


# STRIPE_SIGNING_SECRET=whsec_z6MwgAHWRuHzyYBjHCMnlkHgktXQIxBa rails s
