#!/bin/bash

goal_containerize() {
  docker build . -t shelf2-backend
}

goal_run() {
  rails s -p 3001
}

goal_outdated() {
  bundle outdated
}

goal_linter() {
  bundle exec rubocop -c .rubocop.yml
}

goal_test-unit() {
  bundle exec rake spec:all
}

goal_test-pact() {
  bundle exec rake pact:verify
}

goal_test-container() {
  bundle exec rake spec:infra
}

goal_help() {
  echo "usage: $0 <goal>

goal:

containerize             -- Build the docker container for the app

linter                   -- Run the linter

run                      -- Start the backend application

outdated                 -- Check which dependencies are outdated

test-unit                -- Run unit tests
test-pact                -- Test the pact
test-container           -- Test the container
"
  exit 1
}

main() {
  TARGET=${1:-}
  if [ -n "${TARGET}" ] && type -t "goal_$TARGET" &>/dev/null; then
    "goal_$TARGET" "${@:2}"
  else
    goal_help
  fi
}

main "$@"
