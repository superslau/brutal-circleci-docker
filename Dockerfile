FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    libmagic-dev \
    software-properties-common \
    python-software-properties

RUN sed -i "s/jessie main/jessie main contrib non-free/" /etc/apt/sources.list
RUN echo "deb http://http.debian.net/debian jessie-backports main contrib non-free" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
    ffmpeg

ENV PHANTOMJSVER=2.1.1
RUN curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJSVER-linux-x86_64.tar.bz2 \
   | tar -C /usr/local --no-same-owner -jx \
  && ln -s /usr/local/phantomjs-$PHANTOMJSVER-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs \
  && which phantomjs \
  && echo "PhantomJS version $(phantomjs --version) installed"

# Global install yarn package manager
RUN apt-get update && apt-get install -y curl apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn
