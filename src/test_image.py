"""Test the image by making sure openssl is correctly linked."""

import ssl

import subprocess

if __name__ == "__main__":
    openssl = subprocess.run(
        ["/usr/local/ssl/bin/openssl", "version"], capture_output=True, text=True
    ).stdout
    assert ssl.OPENSSL_VERSION in openssl
