#!/usr/bin/env bash
# exit on error
set -o errexit

# Install gem dependencies
bundle install

# Run database migrations
bundle exec rails db:migrate

# Precompile assets
bundle exec rails assets:precompile

# Clean up old assets
bundle exec rails assets:clean