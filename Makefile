
EXTRA_SNAPS = ../pc-amd64-gadget-desktop/pc-desktop_22-0.3_amd64.snap ../core-base-desktop/core22-desktop_20230904_amd64.snap
ALL_SNAPS = $(EXTRA_SNAPS) eog evince firefox gnome-calculator gnome-characters gnome-clocks gnome-font-viewer gnome-logs gnome-text-editor gnome-weather

all: pc.tar.gz

pc.img: ubuntu-core-desktop-22-amd64.model $(EXTRA_SNAPS)
	rm -rf img/
	ubuntu-image snap --output-dir img --image-size 12G \
	  $(foreach snap,$(ALL_SNAPS),--snap $(snap)) $<
	mv img/pc.img .

%.tar.gz: %.img
	tar czSf $@ $<

cs.img: confined-shell-22-amd64-dangerous.model $(EXTRA_SNAPS)
	rm -rf img/
	ubuntu-image snap --output-dir img --image-size 12G confined-shell-22-amd64-dangerous.model \
	  $(foreach snap,$(EXTRA_SNAPS),--snap $(snap)) $<
	mv img/pc.img cs.img

.PHONY: all
