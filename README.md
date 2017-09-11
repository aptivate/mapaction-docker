[![Build Status](https://travis-ci.org/aptivate/mapaction-docker.svg)](https://travis-ci.org/aptivate/mapaction-docker)

# mapaction-docker

A docker managed [Map Action] deployment.

[Map Action]: https://mapaction.org/

# Get Started

Get a local copy with:

``` bash
$ git clone git@github.com:aptivate/mapaction-docker.git
```

Grab the various plugin code with:

```
$ ./cloner
```

Bring up the deployment with:

``` bash
$ docker-compose build
$ docker-compose up -d
```

The CKAN application should eventually come up up at [http://localhost:5000/].

[http://localhost:5000/]: http://localhost:5000/

# Bootstrap Test Data

You'll need to hit the following URLs and create some test data:

### Create Administrator Account
  * [http://localhost:5000/user/login](http://localhost:5000/user/login)
    * The username is 'admin' and the password is 'password'.

### Create Organisation
  * [http://localhost:5000/organization/new](http://localhost:5000/organization/new)
    * The organistaion should be called `mapaction`.

### Create Event
  * [http://localhost:5000/event/new](http://localhost:5000/event/new)
    * The `operationID` should be `versiontesting`

### Create Tag Vocabularies
  * TODO

### Import Data Set
  * [http://localhost:5000/import_mapactionzip](http://localhost:5000/import_mapactionzip)
    * Import the zip file from `testdata/version_testing_v5.zip`.

# Working With CKAN

In order to connect to the CKAN container, run:

```
$ docker exec -it ckan bash
```

For example, let's run a search index rebuild:

```
$ ckan-paster --plugin=ckan search-index rebuild
```

If you update any deployment configuration, you'll typically want to rebuild
the CKAN container. Ideally, you won't bring down the entire cluster. To do
that, run the following:

```
$ docker rm -f ckan && docker-compose up -d --no-deps --build ckan
```

# Working With The Plugins

All plugins are mounted into the container from the `./plugins` directory,
installed in the `ckan` virtual environment (with the `--editable` flag) and
any file edits on the host machine will result in the paster server live
reloading. Happy Hacking.
