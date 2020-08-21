# avahi-aliases
Yet another version of a python script that allows avahi to announce multiple mDNS CNAMEs pointing to the current host in addition to the default `hostname.local`. This version now supports python3 and runs as a systemd service.

## Installation:
```
sudo ./install.sh
```

## Usage:
`/etc/avahi/aliases` and all files in `/etc/avahi/aliases.d/` contain the list of names that should be CNAME'd to the server, one name per line. Comments are allowed on their own line, starting with a `#`

Aliases can be added to the main alias list:
```
sudo avahi-add-aliases alias.local
```
or to other lists in `/etc/avahi/aliases.d/`:
```
sudo avahi-add-aliases -f myList otheralias.local
```

and removed:
```
sudo avahi-remove-aliases alias.local
```

and listed:
```
$ avahi-list-aliases
/etc/avahi/aliases :
    alias.local
```

## Acknowledgements:
Original sources from avahi: http://www.avahi.org/wiki/Examples/PythonPublishAlias  
Discussion on stackoverflow: http://stackoverflow.com/questions/775233/how-to-route-all-subdomains-to-a-single-host-using-mdns?answertab=votes#tab-top  
And original github repo: https://github.com/airtonix/avahi-aliases
