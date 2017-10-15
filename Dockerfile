FROM starefossen/ruby-node

RUN apt-get update && apt-get install -qq -y build-essential libossp-uuid-dev libmysqlclient-dev --fix-missing --no-install-recommends

ENV RAILS_ROOT /app
ENV RAILS_ENV production

RUN mkdir -p $RAILS_ROOT/tmp/pids

RUN gem install bundler

WORKDIR $RAILS_ROOT

# Install gems before copying files
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

# Install packages before copying files
COPY client/package.json client/package.json
COPY client/yarn.lock client/yarn.lock
RUN cd client && yarn

COPY . .

RUN cd client && yarn run build --production
RUN gzip -rfk client/build/static

CMD rm -Rf public/* && cp -a client/build/. public/ && exec rails s -b 0.0.0.0
