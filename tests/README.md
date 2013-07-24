# Tests!

Tests live in `tests/` and can be in js or coffee.

These tests require Laika and its dependencies to run.

    $ sudo npm install -g laika
    $ sudo npm install -g coffee-script
    $ brew install phantomjs

## Running Tests

First, make sure mongodb is running:

    $ ~/.meteor/tools/latest/mongodb/bin/mongod --smallfiles --noprealloc \
		--nojournal --dbpath ./.meteor/local/db --fork \
		--logpath ./.meteor/local/db-laika.log

Run laika! You'll likely need to have `/usr/local/share/npm/bin` in your `PATH`.

    $ laika --compilers coffee:coffee-script

