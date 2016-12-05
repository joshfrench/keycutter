## Change Log

### 1.0.0

#### Fixed

* the default key will now correctly be reported in all scenarios.

* adding a new key when there is no ~/.gem/credentials file will now no
longer erroneously put the contents of the ~/.gemrc in the newly created
credentials file.

* adding a new key when there is no ~/.gem/credentials file will now create
the credentials file with 0600 permissions.

#### Changed

* api keys will no longer default to being pulled from the ~/.gemrc when the
~/.gem/credentials file does not exist. This behavior was previously not
explicitly dealt with in this library, but removing support could potentially
be a breaking change for some people so the major version is being bumped.

### 0.1.1

* Lazy load Keycutter after the command has been invoked

### 0.1.0

* Initial release
