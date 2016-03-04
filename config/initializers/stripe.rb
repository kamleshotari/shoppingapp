require "stripe"
Rails.configuration.stripe = {
  :publishable_key => "pk_test_pstkz0nOQyTR98oJxvzKkbt7",
  :secret_key      => "sk_test_fToHdnrwERo2psHfJ3PLtb1I" 
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
