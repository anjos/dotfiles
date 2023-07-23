#!/usr/bin/env python3

"""Parses lsregister records

Usage:

    lsregister.py
"""

import pathlib
import re
import subprocess

LSREGISTER = pathlib.Path(
    "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"
)


def get_default_duti(uti: str) -> str:
    try:
        return subprocess.check_output(["duti", "-d", uti]).decode().strip()
    except subprocess.CalledProcessError:
        return "<NO DEFAULT HANDLER>"


def get_records() -> list[tuple[str, str, str]]:
    """Loads all existing records from the program"""
    interested = re.compile(r"^\s*(uti|tags):\s*")

    def _filter_interests(ls):
        return [re.sub(interested, "", k) for k in ls if interested.match(k)]

    assert LSREGISTER.exists(), f"Cannot find lsregister app at {LSREGISTER}"
    print("Reading register... may take a while!")
    output = subprocess.check_output([LSREGISTER, "-dump"]).decode()
    records = re.split(r"-{10,}", output)
    print(f"Found {len(records)} records installed")
    records = [_filter_interests(k.split("\n")) for k in records]
    records = sorted(list(set([tuple(k) for k in records if len(k) == 2])))
    records = [(get_default_duti(k[0]), k[0], k[1]) for k in records]
    print(f"Only {len(records)} match our criteria.")
    return records


if __name__ == "__main__":
    records = get_records()
    for k in records:
        print(f"# {k[2]}\n{k[0]} {k[1]} all\n")
