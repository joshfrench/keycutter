Keycutter
=========

Multiple gemcutter accounts? Manage your keys with ease. Keycutter adds account
management to rubygems, so you can manage gems for multiple accounts or
organizations.

Installation
------------

    gem install keycutter

Usage
-----

Start by adding your current API key. You can name it whatever you want:

    $ gem keys --add personal
       Email:
    Password:

You'll be prompted for your Rubygems.org email and password. If you manage gems
for your company or an open-source organization, add those too:

    $ gem keys --add company
    $ gem keys --add project

You can view your current keys:

    $ gem keys --list
    
    *** CURRENT KEYS ***

       company
     * personal
       project

Your currently active key is marked.

To switch to a different account before pushing a gem:

    $ gem keys --use company

You can also remove a key:

    $ gem keys --remove project

Help is available from the command line:

    $ gem keys --help

TODO
----

 * Add auto-detection of existing API key and create a default key name
 * Rubygems 1.3.7 doesn't support gemcutter-compatible hosts, although this has
   been added to edge. Update `keys --add` to take a `--host` option when the next
   version of rubygems is released.
