buildroot=$1
datadir=$2
systemconfdir=$3

# ---------------------------------------------
# Nautilus
# ---------------------------------------------

# Set the Icon View to Sensible Values

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.nautilus.icon-view.gschema.override << FOE
[org.gnome.nautilus.icon-view]
default-zoom-level="standard"
FOE

# Single Click for Nautilus and hide sidebar

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.nautilus.preferences.gschema.override << FOE
[org.gnome.nautilus.preferences]
click-policy="single"
search-filter-time-type="last_modified"
FOE

# Window State Perferences

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.nautilus.window-state.gschema.override << FOE
[org.gnome.nautilus.window-state]
start-with-sidebar=true
maximized=false
geometry="888x457+41+106"
FOE

# ---------------------------------------------
# GTK
# ---------------------------------------------

# Sort Folders Before Icons

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gtk.settings.file-chooser.gschema.override << FOE
[org.gtk.Settings.FileChooser]
sort-directories-first=true
FOE

# ---------------------------------------------
# Builder
# ---------------------------------------------
cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.builder.editor.gschema.override << FOE
[org.gnome.builder.editor]
highlight-matching-brackets=true
show-grid-lines=false
show-map=true
style-scheme-name="classic"
FOE

# ---------------------------------------------
# Evince
# ---------------------------------------------

# Evince Uses Inverted Colours by Default

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.Evince.Default.gschema.override << FOE
[org.gnome.Evince.Default]
inverted-colors=true
FOE

# ---------------------------------------------
# Eog
# ---------------------------------------------

# EOG Hide Sidebar

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.eog.ui.gschema.override << FOE
[org.gnome.eog.ui]
sidebar=false
FOE

# ---------------------------------------------
# Gedit
# ---------------------------------------------

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.gedit.preferences.editor.gschema.override << FOE
[org.gnome.gedit.preferences.editor]
auto-indent=true
auto-save=true
auto-save-interval=5
bracket-matching=true
create-backup-copy=false
display-line-numbers=true
display-overview-map=true
display-right-margin=true
insert-spaces=true
tabs-size=4
FOE

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.gedit.preferences.ui.gschema.override << FOE
[org.gnome.gedit.preferences.ui]
side-panel-visible=false
statusbar-visible=false
FOE

# ---------------------------------------------
# Liferea
# ---------------------------------------------

# Hide Toolbar, Dont Minimise to Tray and Keep Items
cat >> $buildroot$datadir/glib-2.0/schemas/90_net.sf.liferea.gschema.override << FOE
[net.sf.liferea]
disable-toolbar=true
dont-minimise-to-tray=true
trayicon=false
maxitemcount=999
FOE

# ---------------------------------------------
# Terminal
# ---------------------------------------------

# Terminal Hide Menubar

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.Terminal.Legacy.Settings.gschema.override << FOE
[org.gnome.Terminal.Legacy.Settings]
default-show-menubar=false
FOE

# ---------------------------------------------
# Tilix
# ---------------------------------------------

# Fix Warning on Tilix
cat >> $buildroot$datadir/glib-2.0/schemas/90_com.gexperts.Tilix.Settings.gschema.override << FOE
[com.gexperts.Tilix.Settings]
warn-vte-config-issue=false
FOE

# ---------------------------------------------
# Desktop
# ---------------------------------------------

# Set the Desktop and Lock Screen Backgrounds

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.desktop.background.gschema.override << FOE
[org.gnome.desktop.background]
picture-uri='file://$datadir/backgrounds/dapperlinux/default/ultrahd/dapperlinux.png'
FOE

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.desktop.screensaver.gschema.override << FOE
[org.gnome.desktop.screensaver]
picture-uri='file://$datadir/backgrounds/dapperlinux/default/ultrahd/dapperlinux.png'
FOE

# Ensure Mouse Scrolling is Correct

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.desktop.peripherals.mouse.gschema.override << FOE
[org.gnome.desktop.peripherals.mouse]
natural-scroll=false
FOE

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.desktop.peripherals.touchpad.gschema.override << FOE
[org.gnome.desktop.peripherals.touchpad]
natural-scroll=false
FOE

# Change Desktop And Theme Settings

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.desktop.interface.gschema.override << FOE
[org.gnome.desktop.interface]
clock-show-date=true
gtk-theme="dapper-dark"
icon-theme="Numix-Circle"
FOE

# Clean Up Old Temp Files

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.desktop.privacy.gschema.override << FOE
[org.gnome.desktop.privacy]
remove-old-temp-files=true
remove-old-trash-files=true
old-files-age=1
report-technical-problems=false
FOE

# Set date and time correctly when internet access is present

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.desktop.datetime.gschema.override << FOE
[org.gnome.desktop.datetime]
automatic-timezone=true
FOE

# Set up App folders in overview

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.desktop.app-folders.gschema.override << FOE
[org.gnome.desktop.app-folders]
folder-children="['Utilities', 'Sundry']"

[org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities]
name='X-GNOME-Utilities.directory'
translate=true
categories="['X-GNOME-Utilities']"
apps="['org.gnome.baobab.desktop', 'deja-dup-preferences.desktop', 'eog.desktop', 'evince.desktop', 'org.gnome.FileRoller.desktop', 'gnome-calculator.desktop', 'gnome-dictionary.desktop', 'org.gnome.Characters.desktop', 'org.gnome.DiskUtility.desktop', 'org.gnome.font-viewer.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Screenshot.desktop', 'gnome-system-log.desktop', 'gnome-system-monitor.desktop', 'gnome-tweak-tool.desktop', 'gucharmap.desktop', 'seahorse.desktop', 'vinagre.desktop', 'yelp.desktop', 'dnssec-trigger-panel.desktop', 'chkrootkit.desktop']"

[org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Sundry]
name='X-GNOME-Sundry.directory'
translate=true
categories="['X-GNOME-Sundry']"
apps="['alacarte.desktop', 'authconfig.desktop', 'ca.desrt.dconf-editor.desktop', 'fedora-release-notes.desktop', 'firewall-config.desktop', 'flash-player-properties.desktop', 'gconf-editor.desktop', 'gnome-abrt.desktop', 'gnome-power-statistics.desktop', 'ibus-setup-anthy.desktop', 'ibus-setup.desktop', 'ibus-setup-hangul.desktop', 'ibus-setup-libbopomofo.desktop', 'ibus-setup-libpinyin.desktop', 'ibus-setup-m17n.desktop', 'ibus-setup-typing-booster.desktop', 'im-chooser.desktop', 'itweb-settings.desktop', 'jhbuild.desktop', 'javaws.desktop', 'java-1.8.0-openjdk-jconsole.desktop', 'java-1.8.0-openjdk-policytool.desktop', 'log4j-chainsaw.desktop', 'log4j-logfactor5.desktop', 'nm-connection-editor.desktop', 'orca.desktop', 'setroubleshoot.desktop', 'system-config-date.desktop', 'system-config-firewall.desktop', 'system-config-keyboard.desktop', 'system-config-language.desktop', 'system-config-printer.desktop', 'system-config-users.desktop', 'vino-preferences.desktop']"
FOE

# ---------------------------------------------
# System Modifications
# ---------------------------------------------

# Set most as Manpage Provider for Colour Manpages

cat >> $buildroot$systemconfdir/profile.d/man.sh << FOE
export MANPAGER="/usr/bin/most -s"
FOE

# Load fuse at boot, needed for userspace file systems used by flatpak

cat >> $buildroot$systemconfdir/modules-load.d/fuse.conf << FOE
# Load fuse.ko at boot
fuse
FOE

# Disable gnome-initial-setup since Calamares features user creation
cat >> /etc/sysconfig/anaconda << FOE
# Disable gnome-initial-setup

[General]
post_install_tools_disabled=1
FOE

# Enable MAC Address randomisation
cat >> /etc/NetworkManager/conf.d/00-macrandomize.conf << FOE
[device]
wifi.scan-rand-mac-address=yes

[connection]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
connection.stable-id=${CONNECTION}/${BOOT}
FOE

# ---------------------------------------------
# Shell Extensions
# ---------------------------------------------

# Mediaplayer Settings

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.shell.extensions.mediaplayer.gschema.override << FOE
[org.gnome.shell.extensions.mediaplayer]
indicator-position='right'
position=true
status-size=300
status-text='{trackTitle} - {trackArtist}'
volume=false
button-icon-style='circular'
FOE

# ---------------------------------------------
# Shell
# ---------------------------------------------

# Set Our Favourite Apps for Gnome-Shell and Enable Extensions

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
enabled-extensions=['user-theme@gnome-shell-extensions.gcampax.github.com', 'mediaplayer@patapon.info']
favorite-apps=['com.dapperlinux.Dapper-Hardened-Browser.desktop', 'org.mozilla.Firefox.desktop', 'org.mozilla.Thunderbird.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.gedit.desktop', 'com.gexperts.Tilix.desktop', 'org.gnome.Music.desktop', 'net.sourceforge.liferea.desktop']
FOE

# Set Custom Shell Theme

cat >> $buildroot$datadir/glib-2.0/schemas/90_org.gnome.shell.extensions.user-theme.gschema.override << FOE
[org.gnome.shell.extensions.user-theme]
name="dapper-dark"
FOE

# Make Menu Bars Smaller

cat > $buildroot$datadir/gtk-3.0/gtk.css << FOE
.header-bar.default-decoration {
    padding-top: 3px;
    padding-bottom: 3px;
    border: none;
    background-image: linear-gradient(to bottom,
                                      shade(@theme_bg_color, 1.05),
                                      shade(@theme_bg_color, 0.99));
    box-shadow: inset 0 1px shade(@theme_bg_color, 1.4);
}

.header-bar.default-decoration .button.titlebutton {
    padding-top: 2px;
    padding-bottom: 2px;
}

FOE

# Set Fonts Looking Nice - Requires freetype-freeworld

cat > $buildroot$systemconfdir/fonts/local.conf << FOE
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
    <match target="font">
        <edit name="antialias" mode="assign">
            <bool>true</bool>
        </edit>
        <edit name="autohint" mode="assign">
            <bool>false</bool>
        </edit>
        <edit name="embeddedbitmap" mode="assign">
            <bool>false</bool>
        </edit>
        <edit name="hinting" mode="assign">
            <bool>true</bool>
        </edit>
        <edit name="hintstyle" mode="assign">
            <const>hintslight</const>
        </edit>
        <edit name="lcdfilter" mode="assign">
            <const>lcdlight</const>
        </edit>
        <edit name="rgba" mode="assign">
            <const>rgb</const>
        </edit>
    </match>
</fontconfig>

FOE
