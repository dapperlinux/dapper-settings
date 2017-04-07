# dapper-settings

## About
The Dapper Settings package contains all of the small user interface enhancements and tweaks used in the Dapper Linux distribution. Most of the tweaks are simple gconf setting overrides, but there are some configuration files created. 

dapper-settings are permanent, and carry over into the installed version, while the settings script provided in the kickstarts only effect the live environment.


## Building
To build this package, first install an RPM development chain:

```bash
$ sudo dnf install fedora-packager fedora-review

```

Next, setup rpmbuild directories with

```bash
$ rpmdev-setuptree
```
And place the file dapper-settings.spec in the SPECS directory, and all the rest of the files in the SOURCES directory like so:
```bash
$ mv dapper-settings.spec ~/rpmbuild/SPECS/
$ mv * ~/rpmbuild/SOURCES/
```

and finally, you can build RPMs and SRPMs with:
```bash
$ cd ~/rpmbuild/SPECS
$ rpmbuild -ba dapper-settings.spec
```


