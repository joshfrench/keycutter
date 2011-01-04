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

Upon installation, you'll have your existing rubygems key.

    $ gem keys --list

    *** CURRENT KEYS ***

     * rubygems

If you manage gems for your company or an open-source organization, you can add
additional keys:

    $ gem keys --add work
       Email:
    Password:

You'll be prompted for your Rubygems.org email and password.

If you're using RubyGems 1.4.1 or higher, you can pass the `--host` option to
use a gemcutter-compatible host when adding a key:

    $ gem keys --add internal --host http://gems.mycompany.com

By default, your existing rubygems.org key is used whenever communicating with
gemcutter. To switch the default key used to manage remote gems:

    $ gem keys --default work

Your default key is always marked with a *:

    $ gem keys --list

    *** CURRENT KEYS ***

       internal
       rubygems
     * work
     
You can remove a key:

    $ gem keys --remove project

Help is available from the command line:

    $ gem keys --help

