"""Check image versions, OpenSSL linkage, native modules, and certificate trust."""

import importlib
import os
import platform
import ssl
import subprocess
import sys

if __name__ == "__main__":
    assert platform.python_version() == os.environ["PYTHON_VERSION"]
    assert platform.freedesktop_os_release()["VERSION_ID"] == os.environ["UBUNTU_VERSION"]

    openssl = subprocess.run(
        ["/usr/local/ssl/bin/openssl", "version"],
        capture_output=True,
        text=True,
        check=True,
    ).stdout.strip()
    cli_version, _, library_version = openssl.partition(" (Library: ")
    assert cli_version == ssl.OPENSSL_VERSION, (openssl, ssl.OPENSSL_VERSION)
    if library_version:
        assert library_version.removesuffix(")") == ssl.OPENSSL_VERSION
    if os.environ.get("OPENSSL_VERSION"):
        assert ssl.OPENSSL_VERSION.split()[1] == os.environ["OPENSSL_VERSION"]

    # Catch missing shared libraries in the final stage, including _hashlib.
    for module in (
        "_decimal",
        "_hashlib",
        "bz2",
        "ctypes",
        "curses",
        "dbm.gnu",
        "lzma",
        "readline",
        "sqlite3",
        "zlib",
    ):
        importlib.import_module(module)
    if sys.version_info >= (3, 14):
        from compression import zstd

        assert zstd.decompress(zstd.compress(b"image smoke test")) == b"image smoke test"

    assert ssl.create_default_context().get_ca_certs(), "The OS trust store is empty"
    print(
        f"Python {platform.python_version()} "
        f"on Ubuntu {os.environ['UBUNTU_VERSION']}: {openssl}"
    )
