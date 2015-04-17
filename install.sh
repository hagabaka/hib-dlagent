#!/bin/sh

install -D -m755 hib-dlagent           "$DEST/usr/bin/hib-dlagent"
install -D -m644 README                "$DEST/usr/share/doc/hib-dlagent/README"
install -D -m755 discover-url.py       "$DEST/usr/share/hib-dlagent/discover-url.py"

