import typing
import os
import sys
import argparse
import util

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description=f"copies all files from the system according to {util.LOCATIONS_PATH}",
        epilog=f'''
examples:
{sys.argv[0]} --only vimrc plugin.conf
{sys.argv[0]} --all
        ''',
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    util.argparse_add_process_all_or_only_options(parser)
    args = parser.parse_args()
    if len(sys.argv) == 1:
        parser.print_help(sys.stderr)
        sys.exit(1)

    filtered = None
    if args.all:
        filtered = []
    if not args.all and args.only:
        filtered = args.only

    to_path = util.get_locations_dictionary(util.LOCATIONS_PATH)
    for conf in to_path.keys():
        if filtered and conf not in filtered: continue
        os.system(f'cp -v {to_path[conf]} {conf}')

