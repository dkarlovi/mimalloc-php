# Use

Everything runs in Docker containers.

1. build

```shell
docker compose build
```

2. run Fedora with PHP's `ZendMM` (baseline)

```shell
docker compose run --rm fedora-zendmm
```

3. run another permutation in format `<platform>-<allocator>` to compare against  
    (see matrix below for values), i.e.,

```
docker compose run --rm docker-alpine-malloc
```

## Permutations and rough results

|                                         | `zendmm` | `malloc` | `mimalloc` |
|-----------------------------------------|---------:|---------:|-----------:|
| `fedora` (official packages)            |   0.569s |   0.586s |     0.578s |
| `alpine` (official packages)            |   1.166s |   1.207s |     1.208s |
| `docker-debian` (official Docker image) |   0.700s |   0.706s |        N/A |
| `docker-alpine` (official Docker image) |   0.704s |   0.744s |     0.733s |
