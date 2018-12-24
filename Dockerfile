FROM python:3.6.7 as python

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER kotaru23

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

COPY --from=python /usr/local/src /usr/local
COPY --from=python /usr/local/include /usr/local
COPY --from=python /usr/local/bin /usr/local
COPY --from=python /usr/local/lib /usr/local

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
