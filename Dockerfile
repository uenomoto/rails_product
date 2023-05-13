FROM ruby:latest
RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn

WORKDIR /rails_product
COPY Gemfile Gemfile.lock /rails_product/
RUN bundle install
CMD ["rails", "s", "-b", "0.0.0.0"]
