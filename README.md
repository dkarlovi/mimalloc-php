# Use

1. build

```shell
docker compose build
```

2. run Fedora with PHP's `ZendMM` (baseline)

```shell
docker compose run --rm fedora-zendmm
```

3. run another permutation to compare against (see matrix below)

```
docker compose run --rm docker-alpine-malloc
```

## Permutations and rough results

|                 | `zendmm` | `malloc` | `mimalloc` |
|-----------------|---------:|---------:|-----------:|
| `fedora`        |   0.569s |   0.586s |     0.578s |
| `alpine`        |   1.166s |   1.207s |     1.208s |
| `docker-debian` |   0.700s |   0.706s |        N/A |
| `docker-alpine` |   0.704s |   0.744s |     0.733s |
| `wolfi`         |   0.723s |   0.727s |        N/A |
