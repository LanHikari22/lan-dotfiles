#!/bin/bash

app_name="lan_dotfiles_config"

script_dir=$(dirname "$(realpath "$0")")
project_dir="$script_dir"

PYTHONPATH=$project_dir/src python3 -m $app_name.bin.$BIN $@
