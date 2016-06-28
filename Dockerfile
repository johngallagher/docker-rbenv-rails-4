FROM jolicode/rbenv

RUN cd $HOME/.rbenv && git pull
RUN cd $HOME/.rbenv/plugins/ruby-build && git pull
RUN $HOME/.rbenv/plugins/ruby-build/install.sh

RUN apt-get update
RUN apt-get -q -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev 

ENV RUBY_VERSION 1.9.3-p484
RUN rbenv install $RUBY_VERSION && rbenv local $RUBY_VERSION
RUN gem install --no-ri --no-rdoc bundler
RUN rbenv rehash

ENV RUBY_VERSION 2.1.2
RUN rbenv install $RUBY_VERSION && rbenv local $RUBY_VERSION
RUN gem install --no-ri --no-rdoc bundler
RUN rbenv rehash

ENV RUBY_VERSION 2.1.6
RUN rbenv install $RUBY_VERSION && rbenv local $RUBY_VERSION
RUN gem install --no-ri --no-rdoc bundler
RUN rbenv rehash

ENV RUBY_VERSION 2.3.1
RUN rbenv install $RUBY_VERSION && rbenv local $RUBY_VERSION
RUN gem install --no-ri --no-rdoc bundler
RUN rbenv rehash

RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
ADD .ruby-version /myapp/.ruby-version

RUN rbenv local $(cat /myapp/.ruby-version)
RUN rbenv rehash

RUN which bundle
RUN bundle install
ADD . /myapp
