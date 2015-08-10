PREFIX = /usr

.PHONY: install
install:
	install -D -m 755 hib-dlagent $(DESTDIR)$(PREFIX)/bin/hib-dlagent
	install -D -m 644 README $(DESTDIR)$(PREFIX)/share/doc/hib-dlagent/README
	install -D -m 755 discover-url.py $(DESTDIR)$(PREFIX)/share/hib-dlagent/discover-url.py

.PHONY: uninstall
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/hib-dlagent
	rm -f $(DESTDIR)$(PREFIX)/share/doc/hib-dlagent/README
	rm -f $(DESTDIR)$(PREFIX)/share/hib-dlagent/discover-url.py
