# python-ubuntu-image

A Ubuntu Docker image with the latest Python version built with optimisations and the latest openSSL

# Images

The images can be accessed using `docker pull <image name>`.

| Ubuntu | Python   | Image name                       |
| ------ | -------- | -------------------------------- |
| 20.04  | 3.9.7    | pydoctor/focal-python:3.9.7      |
| 20.04  | 3.10.0   | pydoctor/focal-python:3.10.0     |
| 20.04  | 3.11.0a1 | pydoctor/focal-python:3.11.0a1   |
| 21.04  | 3.9.7    | pydoctor/hirsute-python:3.9.7    |
| 21.04  | 3.10.0   | pydoctor/hirsute-python:3.10.0   |
| 21.04  | 3.11.0a1 | pydoctor/hirsute-python:3.11.0a1 |

# Rationale

Other images are either relying on the outdated Python provided by the distro,
or building it from source against an outdated version of openSSL.

The Dockerfile of these versions also often consists of a single stage, which
makes the code harder to read and tend to leave behind some unnecessary files
(dev headers for packages, etc).

Here, we build Python from source against the latest openSSL version, making
sure to use the RPATH correctly to link to the right version. The first stage
installs the

# Contribute

Feel free to suggest improvements and submit PR, always much appreciated :)
