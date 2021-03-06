FROM ruby:2.7.0

RUN apt-get update -qq && apt-get install -y postgresql-client cmake

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY vendor/cache vendor/cache

RUN bundle install --local

COPY . .

# Some hacky bootstrapping:
RUN echo "*** Using application test configuration for image build ***" \
 && rm config/puma.rb \
 && mv config/database.yml.sample config/database.yml \
 && cp config/userlist_test.yml config/userlist.yml \
 && cp config/credentials/test.key config/credentials/production.key \
 && cp config/credentials/test.yml.enc config/credentials/production.yml.enc

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
