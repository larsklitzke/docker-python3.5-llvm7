# use the latest mysql version
FROM larsklitzke/alpine-llvm7.0:latest
MAINTAINER Lars Klitzke <Lars.Klitzke@gmail.com>

# VERSIONS
ENV PYTHON_VERSION=3.5.7

RUN apk --no-cache add tar wget

# Add the python sources
RUN wget https://github.com/python/cpython/archive/v3.5.7rc1.tar.gz && tar xvf v3.5.7rc1.tar.gz

# replace librressl with openssl
RUN apk --no-cache del libressl-dev

# install build dependencies
RUN apk update && \
    apk --no-cache add \
        build-base \
        gcc \
        wget \
        git \
        g++ \
        openssl-dev \
        make \
        openjpeg-dev \
        tiff-dev \
        zlib-dev \
        libxml2-dev \
        libxslt-dev \
        sqlite \
        sqlite-dev \
        bzip2-dev \
        python3-tkinter \
        ncurses-dev \
        readline-dev \
        xz-dev


RUN cd /cpython-3.5.7rc1 && \
    ./configure --enable-optimizations --enable-loadable-sqlite-extensions && \
    make -j$(nproc) && make test

RUN cd /cpython-3.5.7rc1 && make install



#
## replace librressl with openssl
#RUN apk --no-cache del libressl-dev
#
## add python dev dependencies
#RUN apk --no-cache add \
#	autoconf \
#	automake \
#	freetype-dev \
#	g++ \
#	gcc \
#	jpeg-dev \
#	lcms2-dev \
#	libffi-dev \
#	libpng-dev \
#	libwebp-dev \
#	linux-headers \
#	openssl-dev \
#	make \
#	openjpeg-dev \
#	tiff-dev \
#	zlib-dev \
#	libxml2-dev \
#	libxslt-dev
#
## Ensure pip is installed
#RUN	python3 -m ensurepip && \
#    test -e /usr/bin/pip || ln -s /usr/bin/pip3 /usr/bin/pip;
#
## Upgrade setuptools and install some python packages
#RUN pip install --no-cache-dir -U \
#    setuptools \
#    lxml \
#    pymysql \
#    sqlalchemy \
#    sqlalchemy_utils \
#    marshmallow==3.0.0b13