#!/bin/bash

# fdr - cd to selected directory from specified directory
fd() {
  local dir
  local init_dir
  init_dir=$(pwd)
  [ ! -z "$1" ] && cd "$1"
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
  [ $? != 0 ] && cd $init_dir
}

# fdra - including hidden directories
fda() {
  local dir
  local init_dr
  init_dir="$(pwd)"
  [ ! -z "$1" ] && cd "$1"
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
  [ $? != 0 ] && cd $init_dir
}

# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}
