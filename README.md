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

Download or clone the application from github: > `git clone
https://github.com/riccardo-giomi/rails8-mycv`

Run Bundler: > `cd rails8-mycv` > `bundler install`

Prepare the database: > `bin/rails db:setup`

You can run tests with: > `bin/rails test:all`

And start the server with: > `bin/dev`

# Main features


## CRUD

This application works as a CRUD interface that treats a C.V./Resume, its parts
and its PDF/print layout as a single resource.

A `Copy` button is also available in the cV list page. The new record created
will also inherit the layout and metadata from the original.

The general look, structure and style of the CV is fixed but the interface
allows to change section titles and set page break points that will be used by
the browser when printing/saving as PDF.

### Other CV data (a.k.a. metadata)

You can indicate a `CV language`, this is only for user reference and will not
be shown anywhere in the CV, nor will it be used to translate anything. It will
be shown in the record summary in the CV list page.

`Notes` are... well, notes for the user; they work just like `CV language`.

`Default name for files, without extension` will be used as the default filename
for the browser when saving as PDF or when clicking on `Download as JSON` button.  Also used by the Import/Export Rails commands.

__Note on adding and removing sections__: adding or removing sections like
"Languages" or contacts saves the whole form at the moment. This might save
unwanted data.

### Layout

Any section title can be changed, either to be translated to the language
required for the current CV or to better reflect the CV's purpouse.

The form olso offers some cont

## Preview

A preview page can be opened in a new tab or page; the preview will auto-refresh
on changes to the CV data.  This page has no navbar or controls, but of course
`Print` is available from the browser's menu.

## Print or save as PDF

Printing or saving a CV as a PDF file is left to the browser. The `View` page
has a "Print" button for ease of use, but clicking it is the same as choosing
`Print` from the browser menu (or pressing CTRL-P, at least for Firefox).

When saved as PDF the default filename will be what is set in `Default name for
files, without extension`.

## Quick export as JSON

It is possible to "save" all CV data using the `Download as JSON` button from
the Edit and View pages.
Data will include metadata and layout information.

This is intended as a quick way to backup data before potentially messing things
up.

Re-importing data is left to the `json:import` rails task (see the next
section).

## Import/Export Rails commands

The application allows to import/export CV data as JSON files from the command-line.
For the scope of these commands, all files _must_ be in the `storage/json/` directory.

Files exported via `Download as JSON` button will have to be moved to this
directory to be available for import.

The application introduces three Ruby on Rails command-line commands:

- `bin/rails json list`: lists the filenames of the JSON files available for
  import (useful to copy the filename for use with the next command);

- `bin/rails json import[filename]`: creates a new CV from the data in
  `storage/json/filename` (note that filename must include extension - usually
  _.json_);

- `bin/rails json export[id[, filename]]`: exports the CV with the specified id
  in a file in `storage/json/`; the file name will be taken from the default set
  in `Default name for files, without extension` with the added _.json_
  extension, this can be overridden with the second (optional) argument. 
