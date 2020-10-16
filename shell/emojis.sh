#!/bin/bash

function emojiview() {
    pushd ~/pictures/emojis/ > /dev/null;
    xviewer "$(fzf)"
    popd > /dev/null;
}
