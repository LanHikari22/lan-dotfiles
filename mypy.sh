#!/bin/bash

app_name="lan_dotfiles_config"

script_dir=$(dirname "$(realpath "$0")")
project_dir="$script_dir"

script -q -c "cd $project_dir/src; mypy --strict -m $app_name" /dev/null | tac
