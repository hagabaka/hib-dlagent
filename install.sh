#!/bin/sh

install -D -m755 hib-dlagent           "$DEST/usr/bin/hib-dlagent"
install -D -m644 README                "$DEST/usr/share/doc/hib-dlagent/README"
install -D -m644 discover-url.coffee   "$DEST/usr/share/hib-dlagent/discover-url.coffee"
install -D -m644 util.coffee           "$DEST/usr/share/hib-dlagent/util.coffee"
install -D -m644 phantomjs-config.json "$DEST/etc/hib-dlagent/phantomjs-config.json"
