FROM ubuntu
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y ruby
RUN apt-get install -y ruby-dev
RUN apt-get install -y rubygems-integration
RUN apt-get install -y libmysqlclient-dev
RUN gem install bundler
COPY src/* /etc/app/
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN /usr/local/rvm/bin/rvm requirements
RUN cd /etc/app && bundle install
ENV PORT 9494
WORKDIR /etc/app
#CMD ["bundle", "exec", "rackup", "-p", "$PORT", "-o", "0.0.0.0", "config.ru"]
CMD bundle exec rackup -p "$PORT" -o 0.0.0.0 config.ru
