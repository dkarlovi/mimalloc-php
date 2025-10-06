# Use

1. build
```shell
docker compose build
```

2. run Fedora with PHP's `ZendMM` (baseline)
```shell
docker compose run --rm fedora-zendmm
```

3. run Fedora with Glibc's `malloc`
```shell
docker compose run --rm fedora-malloc
```

4. run Alpine with PHP's `ZendMM`
```shell
docker compose run --rm alpine-zendmm
```

5. run Alpine with Musl's `malloc`
```shell
docker compose run --rm alpine-zendmm
```

6. run Alpine with Microsoft's `mimalloc2` 
```shell
docker compose run --rm alpine-mimalloc2
```
