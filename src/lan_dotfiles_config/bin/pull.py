import os
import sys
import argparse

from ..src.lib import *
from ..src.drivers import *

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description=f"compares config files between repository and system according to {LOCATIONS_PATH}",
        epilog="examples:\n"
        + f"{sys.argv[0]} --only services/vim/.vimrc\n"
        + f"{sys.argv[0]} --all\n",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )

    argparse_add_process_all_or_only_options(parser)

    args = parser.parse_args()

    if len(sys.argv) == 1:
        parser.print_help(sys.stderr)
        sys.exit(1)

    mut_filtered = None

    if args.all:
        mut_filtered = []
    if not args.all and args.only:
        mut_filtered = args.only

    to_path = get_locations_dictionary(LOCATIONS_PATH)

    for conf in to_path.keys():
        if mut_filtered and conf not in mut_filtered:
            continue

        os.system(f"cp -v {to_path[conf]} {conf}")
