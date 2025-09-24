import argparse

def argparse_add_process_all_or_only_options(parser: argparse.ArgumentParser):
    """
    Adds the options to process only selected files, or all of them
    Example:
    prog --only A.conf B.conf       // would only process A.conf and B.conf if they are in the list
    prog --all --only A.conf        // would process everything, --only is ignored
    """
    parser.add_argument('--all', action="store_true",
        help='takes presedence over --only. Processes all files.')
    parser.add_argument('--only', nargs='+',
        help='from the list specified by LOCATIONS_PATH, process only the listed files')
    pass