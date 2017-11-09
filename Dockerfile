FROM ruby:2.4.2-slim

RUN apt-get update && apt-get install -qq -y build-essential libossp-uuid-dev libmysqlclient-dev wget --fix-missing --no-install-recommends

ENV RAILS_ROOT /app
ENV RAILS_ENV production

RUN wget https://releases.hashicorp.com/envconsul/0.7.2/envconsul_0.7.2_linux_amd64.tgz && tar -zxvf envconsul_*.tgz && rm envconsul_*.tgz && ln -sf $PWD/envconsul /usr/bin

RUN mkdir -p $RAILS_ROOT/tmp/pids

RUN gem install bundler

WORKDIR $RAILS_ROOT

# Install gems before copying files
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . .

CMD exec rails s -b 0.0.0.0
