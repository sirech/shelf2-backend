FROM starefossen/ruby-node

RUN apt-get update && apt-get install -qq -y build-essential libossp-uuid-dev libmysqlclient-dev --fix-missing --no-install-recommends

ENV RAILS_ROOT /app
ENV RAILS_ENV production

RUN mkdir -p $RAILS_ROOT/tmp/pids

RUN gem install bundler

WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . .

RUN cd client && yarn
RUN cd client && yarn run build --production
RUN cp -a client/build/. public/

CMD exec rails s
