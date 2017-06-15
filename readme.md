Deploy tmate-slave (backend server used for tmate command line utility) easily using docker.

## Usage
Example command:
```
docker run --publish 2222:2222 --rm --detach --name tmate-slave --volume /var/lib/tmate-slave/keys:/keys aghost7/tmate-slave
```

If there are no keys the container will create them automatically.
