import typing
import argparse

LOCATIONS_PATH = 'locations.txt'

def get_locations_dictionary(path: str) -> typing.Dict[str, str]:
    """
    parses a file of the syntax "
    // ignores lines starting with // or empty lines (or lines with only spaces)
    {conf_file_name_in_repository}: {path_to_conf_file_in_system}
    // example:
    vimrc: ~/.vimrc
    "
    :returns: A dictionary that provides a filename to system path translation
    """
    f = open(path, 'r')
    out = {}
    
    for line in f.readlines():
        if line.startswith('//'): continue
        if line.strip() == '': continue
        if ':' not in line:
            raise Exception('error: invalid locations.txt file')
            
        colon_idx = line.find(':')
        out[line[:colon_idx].strip()] = line[colon_idx+1:].strip()

    return out

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
