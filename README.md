# python-ubuntu-image

A Ubuntu Docker image with the latest Python version built with optimisations
and the latest openSSL.

# Images

The images can be accessed using `docker pull <image name>`.

| Ubuntu | Python   | Image name                        |
| ------ | -------- | --------------------------------- |
| 25.10  | 3.13.13  | ursamajorlab/questing-python:3.13 |
| 25.10  | 3.14.4   | ursamajorlab/questing-python:3.14 |
| 25.10  | 3.15.0b1 | ursamajorlab/questing-python:3.15 |
| 26.04  | 3.13.13  | ursamajorlab/resolute-python:3.13 |
| 26.04  | 3.14.4   | ursamajorlab/resolute-python:3.14 |
| 26.04  | 3.15.0b1 | ursamajorlab/resolure-python:3.15 |

All published tags are multi-arch manifests for `amd64` and `arm64`.

The images are also accessible by using the major.minor.revision tag
`ursamajorlab/<adjective>-python:<full-python-version>`,
e.g. ursamajorlab/noble-python:3.14.4

# Rationale

Other images are either relying on the outdated Python provided by the distro,
or building it from source against an outdated version of openSSL.

The Dockerfile of these versions also often consists of a single stage, which
makes the code harder to read and tend to leave behind some unnecessary files
(dev headers for packages, etc).

Here, we build Python from source against the latest openSSL version, making
sure to use the RPATH correctly to link to the right version.

# Contribute

Feel free to suggest improvements and submit PR, always much appreciated :)
