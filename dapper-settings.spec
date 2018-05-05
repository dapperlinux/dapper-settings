Summary:    Dapper Linux Gnome Settings
Name:       dapper-settings
Version:    28
Release:    1

Group:      System Environment/Base
License:    GPLv3+
Url:        http://github.com/dapperlinux/dapper-settings
Source0:    dapper-settings.sh
Source1:    Default
Source2:    dapper-settings-update
BuildArch:  noarch

Requires(post):   glib2 dconf

Obsoletes:  dapper-settings
Provides:   dapper-settings

%description
Dapper Settings contains all of the custom Gnome configurations that make
Dapper Linux feel modern. 

%prep

%build

%install
mkdir -p %{buildroot}%{_datadir}/glib-2.0/schemas
mkdir -p %{buildroot}%{_datadir}/gtk-3.0
mkdir -p %{buildroot}%{_sysconfdir}/fonts
mkdir -p %{buildroot}%{_sysconfdir}/modules-load.d
mkdir -p %{buildroot}%{_sysconfdir}/profile.d
mkdir -p %{buildroot}%{_sysconfdir}/gdm/PostLogin

# Execute master script to make all config files
sh %{_sourcedir}/dapper-settings.sh %{buildroot} %{_datadir} %{_sysconfdir}

# Move the PostLogin script into place
cp %{SOURCE1} %{buildroot}%{_sysconfdir}/gdm/PostLogin

# Set Postlogin script as executable
chmod +x %{buildroot}%{_sysconfdir}/gdm/PostLogin/Default

mkdir -p %{buildroot}%{_bindir}
install -m 755 %{SOURCE2} %{buildroot}%{_bindir}

%clean
rm -rf %{buildroot}

%pre

%post
# reload changes
glib-compile-schemas /usr/share/glib-2.0/schemas 2>/dev/null
dconf update

%posttrans
dapper-settings-update

%postun
# reload changes
glib-compile-schemas /usr/share/glib-2.0/schemas 2>/dev/null
dconf update

%files
%defattr(-,root,root,-)
%{_datadir}/glib-2.0/schemas/*
%{_datadir}/gtk-3.0/gtk.css
%{_sysconfdir}/fonts/local.conf
%{_sysconfdir}/profile.d/man.sh
%{_sysconfdir}/modules-load.d/fuse.conf
%{_sysconfdir}/gdm/PostLogin/Default
%{_bindir}/%{name}-update

%changelog
* Sat May  5 2018 Matthew Ruffell <msr50@uclive.ac.nz>
- Updating for DL28

* Fri Nov 17 2017 Matthew Ruffell <msr50@uclive.ac.nz>
- Updating for DL27

* Sun Sep  3 2017 Matthew Ruffell <msr50@uclive.ac.nz>
- Splitting posttrans into new dapper-settings-update script and adding existance checks

* Fri Aug 11 2017 Matthew Ruffell <msr50@uclive.ac.nz>
- Updating for F26

* Fri Nov  4 2016 Matthew Ruffell <msr50@uclive.ac.nz>
- Updating for F25

* Wed Oct 19 2016 Matthew Ruffell <msr50@uclive.ac.nz>
- Created dapper-settings
