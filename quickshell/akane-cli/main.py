#!/usr/bin/env python3

import argparse
import sys

from commands.theme import build_parser as build_theme_parser


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="akane-cli")
    commands = parser.add_subparsers(dest="command", required=True)

    build_theme_parser(commands)

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    handler = getattr(args, "handler", None)
    if handler is None:
        parser.print_help()
        return 1
    try:
        handler(args)
    except Exception as error:
        print(str(error), file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
