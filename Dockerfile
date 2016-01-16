FROM ubuntu:15.10

MAINTAINER Matthieu Simonin <matthieu.simonin@inria.fr>

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING UTF-8

RUN apt-get update -qq

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  build-essential\
  ca-certificates\
  git\
  python-pip\
  libzmq3-dev\
  python-dev\
  ruby2.1\
  ruby2.1-dev

RUN gem2.1 install bundler

RUN mkdir -p /notebook
COPY Gemfile /notebook/
WORKDIR /notebook
RUN bundle install

RUN pip install ipython[notebook]
RUN mkdir -p -m 700 /root/.jupyter/ && \
    echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py

