FROM ruby:2.7.4
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /warehouse_control
COPY Gemfile /warehouse_control/Gemfile
COPY Gemfile.lock /warehouse_control/Gemfile.lock
RUN bundle install
COPY . /warehouse_control

# Adicione um script para corrigir um problema com o server.pid do Rails
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Inicia o servidor principal do Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
