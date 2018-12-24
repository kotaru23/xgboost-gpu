FROM nvidia/cuda:9.2-cudnn7-devel-ubuntu18.04
MAINTAINER kotaru23

ENV DEBIAN_FRONTEND=noninteractive

# install library
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    git \
    python3 \
    python3-pip \
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
