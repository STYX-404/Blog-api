FROM ruby:3.0.1
RUN apt-get update -qq && apt-get install -y nodejs 
RUN sudo apt install mysql-server
RUN sudo systemctl start mysql.service
WORKDIR /myapp
COPY . /myapp/
RUN bundle install

ENTRYPOINT ["bin/rails"]
CMD ["server", "-b", "0.0.0.0"]
EXPOSE 3000