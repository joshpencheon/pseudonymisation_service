FROM ruby:2.7.0 as base

RUN apt-get update -qq && apt-get install -y postgresql-client cmake

FROM base as build

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY vendor/cache vendor/cache

RUN bundle install --local
RUN rm -rf vendor/cache

COPY . .

FROM base as packaged

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

WORKDIR /app

# Some hacky bootstrapping:
RUN echo "*** Using application test configuration for image build ***"
RUN rm config/puma.rb
RUN mv config/database.yml.sample config/database.yml
RUN cp config/userlist_test.yml config/userlist.yml
RUN cp config/credentials/test.key config/credentials/production.key
RUN cp config/credentials/test.yml.enc config/credentials/production.yml.enc

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
