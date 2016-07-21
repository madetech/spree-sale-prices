module Spree
  class PreSalePrice < Spree::Base
    acts_as_paranoid

    belongs_to :variant, class_name: 'Spree::Variant',
                         inverse_of: :pre_sale_prices, touch: true

    validate :check_price
    validates :amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validate :validate_amount_maximum

    def display_amount
      money
    end
    alias display_price display_amount

    def money
      Spree::Money.new(amount || 0, { currency: currency })
    end

    def price
      amount || 0
    end

    def price=(price)
      self[:amount] = Spree::LocalizedNumber.parse(price)
    end

    # Remove variant default_scope `deleted_at: nil`
    def variant
      Spree::Variant.unscoped { super }
    end

    def display_amount_no_cents
      money_no_cents
    end
    alias display_price_no_cents display_amount_no_cents

    def to_s
      return '' unless amount.present?

      '%.2f' % amount
    end

    private

    def check_price
      self.currency ||= Spree::Config[:currency]
    end

    def maximum_amount
      BigDecimal '999999.99'
    end

    def validate_amount_maximum
      if amount && amount > maximum_amount
        errors.add :amount, I18n.t('errors.messages.less_than_or_equal_to', count: maximum_amount)
      end
    end

    def money_no_cents
      Spree::Money.new(amount || 0, currency: currency, no_cents: true)
    end
  end
end
