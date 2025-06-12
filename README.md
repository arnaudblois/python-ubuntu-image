# python-ubuntu-image

A Ubuntu Docker image with the latest Python version built with optimisations
and the latest openSSL.

# Images

The images can be accessed using `docker pull <image name>`.

| Ubuntu | Python   | Image name                      |
| ------ | -------- | ------------------------------- |
| 24.04  | 3.12.11  | ursamajorlab/noble-python:3.12  |
| 24.04  | 3.13.5   | ursamajorlab/noble-python:3.13  |
| 24.04  | 3.14.0b2 | ursamajorlab/noble-python:3.14  |
| 25.04  | 3.12.11  | ursamajorlab/plucky-python:3.12 |
| 25.04  | 3.13.5   | ursamajorlab/plucky-python:3.13 |
| 25.04  | 3.14.0b2 | ursamajorlab/plucky-python:3.14 |

The images are also accessible by using the major.minor.revision tag
`ursamajorlab/<adjective>-python:<full-python-version>`,
e.g. ursamajorlab/noble-python:3.12.7

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
