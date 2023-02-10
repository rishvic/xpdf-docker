.POSIX:
.SUFFIXES:

SHELL = /bin/sh

DOCKER    = docker
SHA256SUM = sha256sum

XPDF_VERSION  = 4.04
IMAGE_NAME    = interiit/xpdf
IMAGE_FLAVORS = bullseye bullseye/afl bullseye/gcc focal/afl

XPDF_SRC        = xpdf-$(XPDF_VERSION).tar.gz
SAMPLE_PDFS     = pdfs/dummy.pdf pdfs/poc1
INTEGRITY_FILES = $(XPDF_SRC) $(SAMPLE_PDFS)
SHA256SUM_FILE  = sha256sums.txt

all: images

images: $(IMAGE_FLAVORS)

$(IMAGE_FLAVORS): $(XPDF_SRC)
	$(DOCKER) build -f "dockerfiles/$@/Dockerfile" -t "$(IMAGE_NAME):$(XPDF_VERSION)-$(subst /,-,$@)" .


check: check-sha256

check-sha256: $(INTEGRITY_FILES)
	$(SHA256SUM) -c $(SHA256SUM_FILE)


$(SHA256SUM_FILE): $(INTEGRITY_FILES)
	$(SHA256SUM) $^ > $@

$(XPDF_SRC):
	@echo "FATAL: Could not find $@, exiting..."
	@false

$(SAMPLE_PDFS):

.PHONY: all images $(IMAGE_FLAVORS) check check-sha256
