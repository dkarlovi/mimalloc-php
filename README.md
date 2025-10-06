# Use

1. build
```shell
docker compose build
```

2. run Fedora with Glibc's `malloc` (baseline)
```shell
docker compose run --rm fedora-malloc
```

3. run Alpine with Musl's `malloc`
```shell
docker compose run --rm alpine-malloc
```

4. run Alpine with Microsoft's `mimalloc2` 
```shell
docker compose run --rm alpine-mimalloc2
```
