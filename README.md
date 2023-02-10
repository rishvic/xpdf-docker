# Xpdf Docker Images

This repository contains docker images for [Xpdf](https://www.xpdfreader.com/)
version 4.04, which is vulnerable to [CVE-2022-30524](https://nvd.nist.gov/vuln/detail/CVE-2022-30524).

## Building the Images 📦

This repository contains the image in 3 flavours:

- **bullseye/gcc**: Debian "bullseye", built with gcc
- **bullseye/afl**: Debian "bullseye", built with afl-clang-fast++ (debug profile)
- **focal/afl**: Ubuntu 20.04 LTS (Focal Fossa), built with afl-clang-fast++
  (debug profile)

Their `Dockerfile` are present in their respective directories in [dockerfiles/](dockerfiles)
directory.

The repository is packaged with a [`Makefile`](Makefile) for easier building of
the images. To build any image, run the following command:

```shell
make '<flavor-name>'

# Eg. if building the focal/afl profile
make focal/afl

# If you want to build all the images
make
```

This will generate a Docker image `interiit/xpdf:4.04-<flavor>`. Running just
`make` builds all the images.

## Checking Integrity 🔍

The repository contains the vulnerable version of Xpdf, as well as a few sample
PDF files. The `pdftotext` binary should work on [pdfs/dummy.pdf](pdfs/dummy.pdf),
but should abruptly give segmentation fault on [pdfs/poc1](pdfs/poc1).

To make sure that the files are not corrupted/altered, run `make check`. If the
command errors, it might mean that the files may be corrupted.
