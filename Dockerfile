FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /neuroflow_demo
WORKDIR /neuroflow_demo

COPY Gemfile /neuroflow_demo/Gemfile
COPY Gemfile.lock /neuroflow_demo/Gemfile.lock

RUN bundle install
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn
RUN yarn install --check-files

COPY . /neuroflow_demo
