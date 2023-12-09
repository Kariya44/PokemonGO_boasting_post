ARG RUBY_VERSION=ruby:3.2.2
ARG NODE_VERSION=19

FROM $RUBY_VERSION
ARG RUBY_VERSION
ARG NODE_VERSION
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential nodejs yarn libvips vim
RUN mkdir /PokemonGO_boasting_post
WORKDIR /PokemonGO_boasting_post
RUN gem install bundler
COPY Gemfile /PokemonGO_boasting_post/Gemfile
COPY Gemfile.lock /PokemonGO_boasting_post/Gemfile.lock
COPY yarn.lock /PokemonGO_boasting_post/yarn.lock
RUN bundle install
RUN yarn install
COPY . /PokemonGO_boasting_post