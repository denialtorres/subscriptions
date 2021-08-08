class Charge < ApplicationRecord
  belongs_to :user

  scope :sorted, -> { order(created_at: :desc)}

  default_scope -> {sorted}

  def filename
    "receipt-#{created_at.strftime("%Y-%m-%d")}.pdf"
  end

  def receipt
    Receipts::Receipt.new(
      id: id,
      product: "My Product",
      company: {
        name: "Cratebind, LLC.",
        address: "123 Fake Street\nNew York City, NY 10012",
        email: "support@example.com",
      },
      line_items: line_items,
    )
  end

  def line_items
    [
      ["Date",           created_at.to_s],
      ["Account Billed", "#{user.name} (#{user.email})"],
      ["Product",        "My Product"],
      ["Amount",         ApplicationController.helpers.formatted_amount(amount)],
      ["Charged to",     "#{card_brand} (**** **** **** #{card_last4})"],
    ]
  end
end
