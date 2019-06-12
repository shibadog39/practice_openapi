FROM ruby:2.6.2-slim

RUN apt-get update -qq && apt-get install -y \
    curl build-essential mysql-client default-libmysqlclient-dev \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ENV APP_PATH /usr/src/app
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH
ADD . $APP_PATH
