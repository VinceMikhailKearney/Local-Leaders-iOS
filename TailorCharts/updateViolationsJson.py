#!/usr/bin/python

import json
import os

def update():
    print "Need to update the violations.json file"
    with open('violations.json') as json_data:
        json_data = json.load(json_data)
        pretty_json = json.dumps(json_data, indent=4, sort_keys=True)
        print("violations = %s;" % pretty_json)
        newJavascriptFile = open("data.js","w+")
        newJavascriptFile.write("violations = %s;" % pretty_json)
        newJavascriptFile.close()


if __name__ == "__main__":
    import sys
    update()
