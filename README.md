#Recipe Box
###created by: Jessica Engel

Recipe Box is an easy way to store your favorite recipes and reference them time and time again.
developed with ruby 2.2.0p0


####Setup
_______

Gemfile is included in root folder.

Make sure to bundle gems before using ConcertTracker:

    $ gem install bundler
    $ bundle


Run postgres:

    $ postgres


Create Databases with Active Record:

    $ rake db:create
    $ rake db:migrate
    $ rake db:test:prepare


WARNING this will clear ALL DATA and re-create databases:

    $ rake db:drop
    $ rake db:create
    $ rake db:migrate
    $ rake db:test:prepare


To run program through Sinatra in a new Terminal window:

    $ ruby app.rb


####Debug
________

For bug issues contact Jessicaepdx@gmail.com


####License
_________


The MIT License (MIT)

Copyright (c) 2015 Epicodus
