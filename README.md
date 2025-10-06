# Use

1. build
```shell
docker compose build
```

2. run with Musl's `malloc` (baseline)
```shell
docker compose run --rm malloc
```

3. run with Microsoft's `mimalloc2` 
```shell
docker compose run --rm mimalloc2
```
