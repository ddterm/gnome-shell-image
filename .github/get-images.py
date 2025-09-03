#!/usr/bin/env python3

import argparse
import html.parser
import re
import urllib.request


URL_RE = re.compile(r'.*/packages/container/package/([^/]+)$')


class HTMLParser(html.parser.HTMLParser):
    def handle_starttag(self, tag, attrs):
        if tag != 'a':
            return

        attrs = dict(attrs)
        href = attrs.get('href', None)

        if not href:
            return

        match = URL_RE.match(href)

        if not match:
            return

        print(match.group(1))


def main(url):
    parser = HTMLParser()

    with urllib.request.urlopen(url) as request:
        parser.feed(request.read().decode())


argparser = argparse.ArgumentParser()
argparser.add_argument('url')
main(**vars(argparser.parse_args()))
