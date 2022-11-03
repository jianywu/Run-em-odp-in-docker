# Compile em-odp and run its example application on ubuntu docker image

## How to use

* Docker build

`$ docker build -t jianywu/em-odp:latest ./`

* Docker run

```

$ docker run -it --cpuset-cpus="0-1" --shm-size 512m jianywu/em-odp:latest -c 0x3 -t

$ docker exec -it $container_id sh

# use em_cli
$ telnet 0 55555

```

_Note_: we need to increase the size of share memmory, otherwise, following error would be introduced.

```
$ docker run -it --cpuset-cpus="0-1" jianywu/em-odp:latest -c 0x3 -t

Coremask:   0x3
Core Count: 2
Device-id:  0x0
Thread-per-core mode selected!
HW time counter freq: 2598132347 hz

odp_ishm.c:1272:reserve_single_va():No huge pages, fall back to normal pages. Check: /proc/sys/vm/nr_hugepages.
odp_ishm.c:697:create_file():Normal page memory allocation failed: fd=3, file=/dev/shm/0/odp-1-ishm-single_va, err="No space left on device"
odp_ishm.c:1294:reserve_single_va():Reserving single VA memory failed.
odp_ishm.c:1754:_odp_ishm_init_global():unable to reserve single VA memory
.odp_init.c:349:odp_init_global():ODP ishm init failed.
Appl Error: cm_setup.c:436, init_odp() - ODP global init failed:-1
```
