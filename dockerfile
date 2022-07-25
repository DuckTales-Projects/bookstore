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
    tzdata \
    zsh

WORKDIR /var/www/medical_exams

RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN echo "/bin/zsh" >> ~/.bashrc
RUN echo "alias reload='source ~/.zshrc'" >> ~/.zshrc
RUN echo "alias be='bundle exec'" >> ~/.zshrc

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
