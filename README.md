Publish aliases with Avahi:
How to route all multiple names to a single host using Multicast-DNS?

Tested the installation on ubuntu-10.04 and 11.10.
Tested the clients on windows-vista; ubuntu-10.04 ubuntu-11.10; macosx-snow-leopard.
Original discussions mention that it does not work on windows. I tested it on one machine and it was all smooth. Will confirm.

Server-side requirements on ubuntu:
The debian packages
   avahi-daemon avahi-discover libnss-mdns python-avahi
must be installed.

If you must compile the latest avahi instead of the old one on the debian repo; here are a few hints. (not necessary on 10.10)
sudo apt-get install gettext intltool libtool libexpat-dev libgdbm-dev libdaemon-dev libdbus-1-dev
#git clone git://git.0pointer.de/avahi.git
wget http://www.avahi.org/download/avahi-0.6.30.tar.gz
tar xvf avahi-0.6.30.tar.gz
cd avahi-0.6.30
#in the configure.sh look for the line that checks for python-pygtk.
#just comment it out as we need to compile with python support but without gtk bindings.
./configure --disable-qt3 --disable-qt4 --disable-gtk3 --disable-gobject --disable-glib --disable-gtk --disable-mono --disable-monodoc --enable-core-docs
EO-Compiling avahi on 10.10


Installation:
sudo ./install.sh

Usage:
The file /etc/avahi/aliases contains the list of names that should be aliased to the server: one name per line.
This list can be manipulated with:
  sudo avahi-add-alias the.new.alias.local
and
  sudo avahi-remove-alias the.new.alias.local

The aliases are published by the command:
  sudo avahi-publish-alias

Make sure that all the aliases to publish are in the '.local' domain.
Another domain will throw a "dbus.exceptions.DBusException: org.freedesktop.Avahi.NotSupportedError: Not supported"

Acknowledgements:
Original sources from avahi: http://www.avahi.org/wiki/Examples/PythonPublishAlias
Discussion on stackoverflow: http://stackoverflow.com/questions/775233/how-to-route-all-subdomains-to-a-single-host-using-mdns?answertab=votes#tab-top
And original github repo: https://github.com/airtonix/avahi-aliases
