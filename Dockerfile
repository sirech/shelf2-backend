FROM ruby:3.0.1-alpine

ENV RAILS_ROOT=/app \
  RAILS_ENV=production \
  SECRET_KEY_BASE=123

WORKDIR $RAILS_ROOT
COPY . .

# hadolint ignore=DL3018
RUN apk add --update --no-cache build-base libxml2-dev libxslt-dev mysql-dev tzdata dumb-init \
    && rm -rf /var/cache/apk/* \
    && mkdir -p $RAILS_ROOT/tmp/pids \
    && bundle install --without development test \
    && apk del build-base \
    && rm -Rf /usr/lib/libmysqld*

RUN addgroup -S app && \
    adduser -G app -SHD -h "$RAILS_ROOT" app && \
    chown -R app:app "$RAILS_ROOT"
USER app

EXPOSE 3000

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["rails", "s", "-b", "0.0.0.0"]
