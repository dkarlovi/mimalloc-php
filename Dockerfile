FROM alpine:3.22.1 AS alpine-runtime
RUN apk add --no-cache \
        php84-cgi \
        php84-cli \
        php84-gmp \
        php84-mbstring \
        php84-mysqli \
        php84-opcache \
        php84-sockets  \
    && ln -s /usr/bin/php84 /usr/bin/php \
    && ln -s /usr/bin/php-cgi84 /usr/bin/php-cgi
RUN mkdir /benckmarks /work \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/bench.php -O /benckmarks/bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/Zend/micro_bench.php -O /benckmarks/micro_bench.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/benchmark.php -O /benckmarks/benchmark.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/generate_diff.php -O /benckmarks/generate_diff.php \
    && wget https://raw.githubusercontent.com/php/php-src/refs/heads/master/benchmark/shared.php -O /benckmarks/shared.php
WORKDIR /work
CMD ["php", "/benckmarks/micro_bench.php"]

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

FROM fedora-runtime AS fedora-malloc

FROM alpine-runtime AS alpine-malloc
FROM alpine-runtime AS alpine-mimalloc2
RUN apk add --no-cache \
        mimalloc2
ENV LD_PRELOAD=/usr/lib/libmimalloc.so.2
# ENV MIMALLOC_ALLOW_LARGE_OS_PAGES=1
# ENV MIMALLOC_SHOW_STATS=1
# ENV MIMALLOC_SHOW_ERRORS=1
