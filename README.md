# Xpdf Docker Images

This repository contains docker images for [Xpdf](https://www.xpdfreader.com/)
version 4.04, which is vulnerable to [CVE-2022-30524](https://nvd.nist.gov/vuln/detail/CVE-2022-30524).

## Building the Images 📦

This repository contains the image in 2 flavours:

- _bullseye/gcc_: Debian "bullseye", built with gcc
- _bullseye/afl_: Debian "bullseye", built with afl-clang-fast++ (debug profile)
- _focal/afl_: Ubuntu 20.04 LTS (Focal Fossa), built with afl-clang-fast++
  (debug profile)

Their `Dockerfile` are present in their respective directories in [dockerfiles/](dockerfiles)
directory.

The repository is packaged with a [`Makefile`](Makefile) for easier building of
the images. To build any image, run `make <flavor-name>` to build the
corresponding image. Running just `make` builds all the images.

## Checking Integrity 🔍

The repository contains the vulnerable version of Xpdf, as well as a few sample
PDF files. The `pdftotext` binary should work on [pdfs/dummy.pdf](pdfs/dummy.pdf),
but should abruptly give segmentation fault on [pdfs/poc1](pdfs/poc1).

To make sure that the files are not corrupted/altered, run `make check`. If the
command errors, it might mean that the files may be corrupted.
