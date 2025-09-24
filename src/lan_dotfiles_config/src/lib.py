import typing

LOCATIONS_PATH = "locations.txt"


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
    f = open(path, "r")

    mut_out = {}

    for line in f.readlines():
        if line.startswith("//"):
            continue

        if line.strip() == "":
            continue

        if ":" not in line:
            raise Exception("error: invalid locations.txt file")

        colon_idx = line.find(":")

        mut_out[line[:colon_idx].strip()] = line[colon_idx + 1 :].strip()

    return mut_out
