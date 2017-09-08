# mapaction-docker

WORK.IN.PROGRESS.

This is a fork of the [contrib/docker] setup from the core CKAN repository.

It's a CKAN deployment with all Aptivate's [mapaction plugins] installed and some test data loaded.

[contrib/docker]: https://github.com/ckan/ckan/tree/master/contrib/docker
[mapaction plugins]: https://github.com/aptivate?utf8=%E2%9C%93&q=mapaction&type=&language=

# Hack It

Firstly, install [docker] and [docker-compose].

[docker]: https://www.docker.com/
[docker-compose]: https://docs.docker.com/compose/

Then get a local copy:

``` bash
$ git clone git@github.com:aptivate/mapaction-docker.git
```

Then, setup a virtualenv and get [docker-compose] installed:


``` bash
$ python3 -m venv .venv
$ source .venv/bin/activate
$ pip install -r requirements.txt
```

Now, you'll need to get local copies of the plugins we use - run that script:

```
$ ./cloner
```

This will create a `src` directory with all the necessary plugins. These will
then be mounted into the CKAN docker container so we can hack on them and see
our changes immediately. The `paster serve` command is configured to live
reload also.

And finally, build and bring up the images with:

``` bash
$ docker-compose build
$ docker-compose up
```

The CKAN image is built using a [custom docker image].

[custom docker image]: https://hub.docker.com/r/aptivate/ckan-mapaction/

To quickly reset a container within the cluster, run:

``` bash
# In this example, we're interested in the `ckan` container
$ docker kill ckan && docker rm -f ckan
$ docker-compose up -d --no-deps --build ckan
```
