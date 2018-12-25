FROM alpine:3.8 as downloader

ENV PYTHON_VERSION 3.6.8

RUN apk add --no-cache wget tar xz

WORKDIR /usr/local/src
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz && \
    tar xf Python-${PYTHON_VERSION}.tar.xz


FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER kotaru23

ENV PYTHON_VERSION 3.6.8
ENV DEBIAN_FRONTEND=noninteractive

# install library
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    git \
    build-essential \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    tk-dev \
    libffi-dev \
    gfortran \
    libopenblas-dev \
    liblapack-dev  && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY --from=downloader /usr/local/src/Python-${PYTHON_VERSION} /usr/local/src/python

WORKDIR /usr/local/src/python/
RUN ./configure --with-ensurepip --enable-optimizations && \
    make -j && \
    make install && \
    rm -rf /usr/local/src/python


RUN pip3 install --no-cache-dir \
    numpy \
    scipy \
    scikit-learn \
    xgboost \
    imbalanced-learn \
    h5py \
    joblib \
    tqdm \
    click

WORKDIR /apps

CMD ["python3"]
