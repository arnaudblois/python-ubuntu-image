# python-ubuntu-image

A Ubuntu Docker image with the latest Python version built with optimisations
and the latest openSSL.

# Images

The images can be accessed using `docker pull <image name>`.

| Ubuntu | Python    | Image name                       |
| ------ | --------- | -------------------------------- |
| 20.04  | 3.9.13    | ursamajorlab/focal-python:3.9    |
| 20.04  | 3.10.6    | ursamajorlab/focal-python:3.10   |
| 20.04  | 3.11.0rc1 | ursamajorlab/focal-python:3.11   |
| 22.04  | 3.9.13    | ursamajorlab/jammy-python:3.9    |
| 22.04  | 3.10.6    | ursamajorlab/jammy-python:3.10   |
| 22.04  | 3.11.0rc1 | ursamajorlab/jammy-python:3.11   |

The images are also accessible by using the major.minor.revision tag
`ursamajorlab/<adjective>-python:<full-python-version>`,
e.g. ursamajorlab/focal-python:3.10.6

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
