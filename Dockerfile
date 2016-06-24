FROM madetech/rails-deps

RUN mkdir -p /app
WORKDIR /app
COPY lib/spree_pre_sale_prices/version.rb ./lib/spree_pre_sale_prices/version.rb
COPY Gemfile Gemfile.lock spree_pre_sale_prices.gemspec ./
RUN bundle install --jobs 20 --retry 5
EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]
