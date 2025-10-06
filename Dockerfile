FROM fedora:43 AS fedora-runtime
RUN dnf install -y \
        php-cli \
        php-gmp \
        php-mbstring \
        php-mysqlnd \
        php-opcache \
        php-sockets \
        wget \
    && dnf clean all
RUN mkdir /benckmarks /work \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/bench.php -O /benckmarks/bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/micro_bench.php -O /benckmarks/micro_bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/benchmark.php -O /benckmarks/benchmark.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/generate_diff.php -O /benckmarks/generate_diff.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/shared.php -O /benckmarks/shared.php
WORKDIR /work
CMD ["php", "/benckmarks/micro_bench.php"]
FROM fedora-runtime AS fedora-zendmm
FROM fedora-runtime AS fedora-malloc
ENV USE_ZEND_ALLOC=0

FROM alpine:3.22 AS alpine-runtime
RUN apk add --no-cache \
        php-cli \
        php-gmp \
        php-mbstring \
        php-mysqli \
        php-opcache \
        php-sockets \
        wget \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir /benckmarks /work \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/bench.php -O /benckmarks/bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/micro_bench.php -O /benckmarks/micro_bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/benchmark.php -O /benckmarks/benchmark.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/generate_diff.php -O /benckmarks/generate_diff.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/shared.php -O /benckmarks/shared.php
WORKDIR /work
CMD ["php", "/benckmarks/micro_bench.php"]
FROM alpine-runtime AS alpine-zendmm
FROM alpine-runtime AS alpine-malloc
ENV USE_ZEND_ALLOC=0
FROM alpine-runtime AS alpine-mimalloc
RUN apk add --no-cache \
        mimalloc2
ENV LD_PRELOAD=/usr/lib/libmimalloc.so.2
ENV USE_ZEND_ALLOC=0
# ENV MIMALLOC_ALLOW_LARGE_OS_PAGES=1
# ENV MIMALLOC_SHOW_STATS=1
# ENV MIMALLOC_SHOW_ERRORS=1

FROM php:8.4.13 AS docker-debian-runtime
RUN apt-get update && apt-get install -y \
        wget \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir /benckmarks /work \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/bench.php -O /benckmarks/bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/micro_bench.php -O /benckmarks/micro_bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/benchmark.php -O /benckmarks/benchmark.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/generate_diff.php -O /benckmarks/generate_diff.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/shared.php -O /benckmarks/shared.php
WORKDIR /work
CMD ["php", "/benckmarks/micro_bench.php"]
FROM docker-debian-runtime AS docker-debian-zendmm
FROM docker-debian-runtime AS docker-debian-malloc
ENV USE_ZEND_ALLOC=0
FROM docker-debian-runtime AS docker-debian-mimalloc
RUN apt-get update && apt-get install -y \
        libmimalloc3 \
    && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libmimalloc.so.3
ENV USE_ZEND_ALLOC=0
# ENV MIMALLOC_ALLOW_LARGE_OS_PAGES=1
# ENV MIMALLOC_SHOW_STATS=1
# ENV MIMALLOC_SHOW_ERRORS=1

FROM php:8.4.13-alpine AS docker-alpine-runtime
RUN mkdir /benckmarks /work \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/bench.php -O /benckmarks/bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/micro_bench.php -O /benckmarks/micro_bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/benchmark.php -O /benckmarks/benchmark.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/generate_diff.php -O /benckmarks/generate_diff.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/shared.php -O /benckmarks/shared.php
WORKDIR /work
CMD ["php", "/benckmarks/micro_bench.php"]
FROM docker-alpine-runtime AS docker-alpine-zendmm
FROM docker-alpine-runtime AS docker-alpine-malloc
ENV USE_ZEND_ALLOC=0
FROM docker-alpine-runtime AS docker-alpine-mimalloc
RUN apk add --no-cache \
        mimalloc2
ENV LD_PRELOAD=/usr/lib/libmimalloc.so.2
ENV USE_ZEND_ALLOC=0
# ENV MIMALLOC_ALLOW_LARGE_OS_PAGES=1
# ENV MIMALLOC_SHOW_STATS=1
# ENV MIMALLOC_SHOW_ERRORS=1
