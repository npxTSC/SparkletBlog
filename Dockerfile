# Use an official Ruby image as the base
FROM ruby:latest

# Install dependencies
RUN apt-get update && apt-get install -y build-essential

# Install Jekyll
RUN gem install jekyll bundler

# Create a working directory
WORKDIR /srv/jekyll

# Install site dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Set the volume for your site
VOLUME /srv/jekyll

# Command to build the Jekyll site
CMD ["bundle", "exec", "jekyll", "build"]
