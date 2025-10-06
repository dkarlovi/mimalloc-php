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

FROM php:8.4.13-alpine AS alpine-runtime
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
FROM alpine-runtime AS alpine-mimalloc2
RUN apk add --no-cache \
        mimalloc2
ENV LD_PRELOAD=/usr/lib/libmimalloc.so.2
ENV USE_ZEND_ALLOC=0
# ENV MIMALLOC_ALLOW_LARGE_OS_PAGES=1
# ENV MIMALLOC_SHOW_STATS=1
# ENV MIMALLOC_SHOW_ERRORS=1
