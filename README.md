# MyCV

A simple application to keep resumes up-to-date and easy to print or make into a
PDF file.

It allows to create different resumes in different languages, or with different
styles and foci.

This README would normally document whatever steps are necessary to get the
application up and running.

# Installation

MyCV is a Rails 8 application developed with Ruby 3.2.2 and configured to use
SQLite3 as a DB - it is a simple application intended for use by a single user.

Requires: `Ruby` ( >= 3.2.2) and `SQlite3`.

Download or clone the application from github:
> `git clone https://github.com/riccardo-giomi/mycv`

Run Bundler:
> `cd mycv`
> `bundler install`

Prepare the database:
> `bin/rails db:setup`

You can run tests with:
> `bin/rails test:all`

And start the server with:
> `bin/dev`
