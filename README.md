[![Code Climate](https://codeclimate.com/github/madetech/spree_pre_sale_prices/badges/gpa.svg)](https://codeclimate.com/github/madetech/spree_abandoned_orders) [![Build Status](https://travis-ci.org/madetech/spree_pre_sale_prices.svg?branch=master)](https://travis-ci.org/madetech/spree_abandoned_orders) [![Test Coverage](https://codeclimate.com/github/madetech/spree_pre_sale_prices/badges/coverage.svg)](https://codeclimate.com/github/madetech/spree_abandoned_orders/coverage)


# Pre Sale Prices for Spree

Add pre-sale prices to Spree, so you can show the pre-sale price alongside the currently discounted price.

## Installing

```ruby
# Add to your Gemfile
gem 'spree_pre_sale_prices', github: 'madetech/spree_pre_sale_prices'

# Install the migrations
bin/rake spree_pre_sale_prices:install:migrations
```


## Using

You can query products and variants:

```ruby
product = Spree::Product.first
variant = product.variants.first

product.pre_sale_price_in('GBP').amount.to_s  # => '200.0'

variant.pre_sale_price_in('USD').amount.to_s  # => '100.0'

product.on_sale?                              # => true
```

And create new pre-sale prices:

```ruby
variant = Spree::Variant.first

pre_sale_price = variant.pre_sale_price_in('USD')
pre_sale.price.amount = 100
pre_sale_price.save

variant.pre_sale_price_in('USD').amount.to_s  # => '100.0'
```


## Testing

```ruby
bundle
bundle exec rake test_app
bundle exec rspec
```

## Credits

![made](https://s3-eu-west-1.amazonaws.com/made-assets/googleapps/google-apps.png)

Developed and maintained by [Made Tech Ltd](https://www.madetech.com/). Key contributions:

* [Chris Blackburn](https://github.com/chrisblackburn)


## License
Copyright © 2016 [Made Tech Ltd](https://www.madetech.com/). It is free software, and may be redistributed under the terms specified in the LICENSE file.
