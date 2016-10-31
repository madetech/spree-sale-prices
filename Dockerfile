FROM ubuntu:14.04

RUN apt-get update -qq
RUN apt-get -y install build-essential git openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev libmysqlclient-dev libpq-dev imagemagick libffi-dev nodejs npm nodejs-legacy mysql-client
RUN npm install -g phantomjs

RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
  cd /tmp/ruby-build && \
  ./install.sh && \
  cd / && \
  rm -rf /tmp/ruby-build

RUN ruby-build -v 1.9.3-p194 /usr/local
RUN gem install bundler rubygems-bundler --no-rdoc --no-ri
RUN gem regenerate_binstubs

RUN mkdir -p /app
WORKDIR /app
COPY lib/spree_pre_sale_prices/version.rb ./lib/spree_pre_sale_prices/version.rb
COPY Gemfile spree_pre_sale_prices.gemspec ./
RUN bundle install --jobs 20 --retry 5
EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000"]
