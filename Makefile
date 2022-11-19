OUT=about.html about.html.sig

all: $(OUT)

%.md: %.template
	DATE_ISO_8601=$$(date --iso-8601) \
	GIT_REMOTE_ORIGIN_URL=$$(git config --get remote.origin.url) \
		      envsubst <$^ >$@

%.sig: %
	gpg --yes --armor --output $@ --detach-sign $^

%.html: %.md
	pandoc -s -f markdown -t html $< >$@

clean:
	$(RM) $(OUT)

.PHONY: all clean
