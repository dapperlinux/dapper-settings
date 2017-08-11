Summary:    Dapper Linux Gnome Settings
Name:       dapper-settings
Version:    26
Release:    1

Group:      System Environment/Base
License:    GPLv3+
Url:        http://github.com/dapperlinux/dapper-settings
Source0:    dapper-settings.sh
Source1:    Default
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
mkdir -p %{buildroot}%{_sysconfdir}/gdm/PostLogin

# Execute master script to make all config files
sh %{_sourcedir}/dapper-settings.sh %{buildroot} %{_datadir} %{_sysconfdir}

# Move the PostLogin script into place
cp %{SOURCE1} %{buildroot}%{_sysconfdir}/gdm/PostLogin

# Set Postlogin script as executable
chmod +x %{buildroot}%{_sysconfdir}/gdm/PostLogin/Default

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
# polkitd needs to access /proc to function
usermod -aG proc_access polkitd
systemctl restart polkit

# Remove annoying icons
sh -c 'echo "NoDisplay=true" >> /usr/share/applications/dnssec-trigger-panel.desktop'
sh -c 'echo "NoDisplay=true" >> /usr/share/applications/lash-panel.desktop'
sh -c 'echo "NoDisplay=true" >> /usr/share/applications/xpra-launcher.desktop'
sh -c 'echo "NoDisplay=true" >> /usr/share/applications/xpra-browser.desktop'
sh -c 'echo "NoDisplay=true" >> /usr/share/applications/xpra.desktop'
java_jconsole=/usr/share/applications/java-1.8.0-openjdk-*-jconsole.desktop
java_policytool=/usr/share/applications/java-1.8.0-openjdk-*-policytool.desktop
rm $java_jconsole &> /dev/null || :
rm $java_policytool &> /dev/null || :
sed -i "s/Categories=GNOME;GTK;Utility;Calculator;/Categories=GNOME;GTK;Utility;Calculator;X-GNOME-Utilities;/g" /usr/share/applications/org.gnome.Calculator.desktop

# Fix Nautilus Icon
ln -sf /usr/share/icons/Numix-Circle/48/apps/file-manager.svg /usr/share/icons/Numix-Circle/48/apps/org.gnome.Nautilus.svg

# Fix Tilix Icon
ln -sf /usr/share/icons/Numix-Circle/48/apps/terminix.svg /usr/share/icons/Numix-Circle/48/apps/com.gexperts.Tilix.svg

# Make sure XServer gets used as default
#sed -i -e "/\[daemon\]/a WaylandEnable=false" /etc/gdm/custom.conf

# Enable DNSSEC through NetworkManager
sh -c 'echo "dns=unbound" >> /etc/NetworkManager/NetworkManager.conf'

# Set Grub to boot the first kernel, not the last saved kernel
sed -i "s/GRUB_DEFAULT=saved/GRUB_DEFAULT=0/g" /etc/default/grub

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
%{_sysconfdir}/profile.d/xpra.sh
%{_sysconfdir}/gdm/PostLogin/Default

%changelog
* Fri Aug 11 2017 Matthew Ruffell <msr50@uclive.ac.nz>
- Updating for F26

* Fri Nov  4 2016 Matthew Ruffell <msr50@uclive.ac.nz>
- Updating for F25

* Wed Oct 19 2016 Matthew Ruffell <msr50@uclive.ac.nz>
- Created dapper-settings
