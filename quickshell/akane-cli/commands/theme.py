import argparse

from modules.theme import apply_theme


def _theme_set_command(args: argparse.Namespace) -> None:
    apply_theme(args.image)


def build_parser(commands: argparse._SubParsersAction) -> argparse.ArgumentParser:
    theme_parser = commands.add_parser("theme")
    theme_commands = theme_parser.add_subparsers(dest="theme_command", required=True)

    theme_set_parser = theme_commands.add_parser("set")
    theme_set_parser.add_argument("image")
    theme_set_parser.set_defaults(handler=_theme_set_command)

    return theme_parser
