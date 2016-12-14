Summary:    Dapper Linux Gnome Settings
Name:       dapper-settings
Version:    25
Release:    4

Group:      System Environment/Base
License:    GPLv3+
Url:        http://github.com/dapperlinux/dapper-settings
Source0:    dapper-settings.sh
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
mkdir -p %{buildroot}%{_sysconfdir}/profile.d

sh %{_sourcedir}/dapper-settings.sh %{buildroot} %{_datadir} %{_sysconfdir}

%clean
rm -rf %{buildroot}

%pre

%post
# reload changes
glib-compile-schemas /usr/share/glib-2.0/schemas 2>/dev/null
dconf update

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

%changelog
* Fri Nov  4 2016 Matthew Ruffell <msr50@uclive.ac.nz>
- Updating for F25

* Wed Oct 19 2016 Matthew Ruffell <msr50@uclive.ac.nz>
- Created dapper-settings
