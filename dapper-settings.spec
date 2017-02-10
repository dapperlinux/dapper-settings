Summary:    Dapper Linux Gnome Settings
Name:       dapper-settings
Version:    25
Release:    7

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
# Grsecurity sets gid 1001 to allow access to /proc
/usr/bin/getent group proc_access || /usr/sbin/groupadd -g 1001 proc_access

%post
# reload changes
glib-compile-schemas /usr/share/glib-2.0/schemas 2>/dev/null
dconf update

%posttrans
#polkitd needs to access /proc to function
usermod -aG proc_access polkitd
systemctl restart polkit

# Remove annoying icons
sh -c 'echo "NoDisplay=true" >> /usr/share/applications/lash-panel.desktop'
sh -c 'echo "NoDisplay=true" >> /usr/share/applications/xpra_launcher.desktop'

# Fin Nautilus Icon
ln -sf /usr/share/icons/Numix-Circle/48/apps/file-manager.svg /usr/share/icons/Numix-Circle/48/apps/org.gnome.Nautilus.svg

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
