FactoryGirl.define do
  factory :pre_sale_price, class: Spree::PreSalePrice do
    amount 19.99
    currency 'USD'
  end
end
