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

If you're using RubyGems 1.4.1 or higher, you can pass the `--host` option to
use a gemcutter-compatible host when adding a key:

    $ gem keys --add internal --host http://gems.mycompany.com

You can view your current keys:

    $ gem keys --list
    
    *** CURRENT KEYS ***

       company
     * personal
       project

Your default key is marked.

To switch the default key used when managing remote gems:

    $ gem keys --default company

You can also remove a key:

    $ gem keys --remove project

Help is available from the command line:

    $ gem keys --help

