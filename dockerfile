FROM ruby:3.1.0-alpine

LABEL name="Alpine-Ruby-3.1.0" \
      version="1.0" \
      author="Jhonny Toledo"

RUN apk add --update --no-cache \
    build-base \
    bash \
    coreutils \
    git \
    postgresql-dev \
    less \
    tzdata

WORKDIR /var/www/medical_exams

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN echo "America/Sao_Paulo" >  /etc/timezone

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

RUN gem update --system && \
    gem install bundler && \
    gem cleanup

RUN bundle install

EXPOSE 3000

CMD bundle exec rails s -b 0.0.0.0 -p 3000
