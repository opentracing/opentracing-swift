#!/usr/bin/env python

from __future__ import print_function
import json
import os
import subprocess
import sys


def newest_ios_version(devices):
    ios_versions = [version for version, sims in devices.iteritems()
                    if sims and version.startswith("iOS ")]
    ios_versions = sorted(ios_versions, key=lambda x: float(x.split()[-1]))
    return ios_versions[-1] if ios_versions else None


def newest_device(devices):
    devices = filter(lambda x: x["name"].startswith("iPhone"), devices)
    devices = sorted(devices, key=lambda x: x["name"].split(" ")[-1])
    return devices[-1]["udid"]

DEVNULL = open(os.devnull, 'wb')
simulators_json = subprocess.check_output(["xcrun", "simctl", "list",
                                           "devices", "-j"],
                                          stderr=DEVNULL).decode()

try:
    json_devices = json.loads(simulators_json)["devices"]
    newest_devices = json_devices[newest_ios_version(json_devices)]
    print(newest_device(newest_devices))
except (KeyError, IndexError) as e:
    print("Received malformed JSON from simctl: '{}'".format(simulators_json),
          file=sys.stderr)
    raise e