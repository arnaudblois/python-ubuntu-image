# python-ubuntu-image

Ubuntu Docker images supporting the three latest stable Python minor versions
on the latest Ubuntu release and the latest Ubuntu LTS. Python is built from
source with optimisations and the latest stable OpenSSL.

The current builds use OpenSSL **4.1.0**. Release versions were checked on
2026-10-30 against [Python](https://www.python.org/downloads/),
[Ubuntu](https://releases.ubuntu.com/), and
[OpenSSL](https://openssl-library.org/source/).

# Images

The images can be accessed using `docker pull <image name>`.

| Ubuntu       | Python  | Image name                        |
| ------------ | ------- | --------------------------------- |
| 26.04 LTS    | 3.13.18 | ursamajorlab/resolute-python:3.13  |
| 26.04 LTS    | 3.14.10 | ursamajorlab/resolute-python:3.14  |
| 26.04 LTS    | 3.15.2  | ursamajorlab/resolute-python:3.15  |
| 26.10        | 3.13.18 | ursamajorlab/stonking-python:3.13  |
| 26.10        | 3.14.10 | ursamajorlab/stonking-python:3.14  |
| 26.10        | 3.15.2  | ursamajorlab/stonking-python:3.15  |

All published tags are multi-arch manifests for `amd64` and `arm64`.

The images are also accessible by using the major.minor.revision tag
`ursamajorlab/<adjective>-python:<full-python-version>`,
e.g. `ursamajorlab/resolute-python:3.15.2`.

Build and test a specific combination locally from the repository root:

```bash
export DOCKERHUB_USERNAME=ursamajorlab
export UBUNTU_VERSION=26.04
export PYTHON_VERSION=3.15.2
export OPENSSL_VERSION=4.1.0
bash src/build_image.sh
bash src/test_image.sh
```

CI builds and tests all six Python/Ubuntu combinations on both `amd64` and
`arm64`. Branch and pull request builds set
`QUICK_BUILD=true` to skip Python optimisations and OpenSSL's upstream test suite;
the image smoke tests still run. Builds on `main` run the full OpenSSL test suite
and enable Python optimisations before publishing both tag formats.

Python 3.13 and 3.14 builds include compatibility flags for fixed-version TLS
methods removed in OpenSSL 4, as described in the
[CPython issue](https://github.com/python/cpython/issues/159391).

# Rationale

Other images are either relying on the outdated Python provided by the distro,
or building it from source against an outdated version of OpenSSL.

The Dockerfile of these versions also often consists of a single stage, which
makes the code harder to read and tend to leave behind some unnecessary files
(dev headers for packages, etc).

Here, we build Python from source against the latest OpenSSL version, making
sure to use the RPATH correctly to link to the right version.

# Contribute

Feel free to suggest improvements and submit PR, always much appreciated :)
