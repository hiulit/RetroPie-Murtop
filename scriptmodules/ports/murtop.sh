#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="murtop"
rp_module_desc="Murtop - A fast-paced 80's arcade-style game where Dig Dug meets Bomberman."
rp_module_license="MIT https://github.com/hiulit/RetroPie-Murtop/blob/main/LICENSE"
rp_module_section="opt"
rp_module_flags="x86 x86_64 arm aarch64"

readonly GAME_BIN_DIR="/home/$user/RetroPie-Murtop/bin"


function install_bin_murtop() {
    local game_zip_file

    game_zip_file="$(find "$GAME_BIN_DIR" -type f -name "*.zip")"
    
    if [[ "$?" -ne 0 ]]; then
        fatalError "You must create '$GAME_BIN_DIR' and then place 'murtop_[VERSION]_[ARCH].zip' in it."
    fi

    if [[ -z "$game_zip_file" ]]; then
        fatalError "ERROR: You must place 'murtop_[ARCH].zip' in '$GAME_BIN_DIR'."
    fi

    unzip -o "$game_zip_file" -d "$md_inst"
}


function configure_murtop() {
    local cmd

    cmd="$(find "$md_inst" -not -name "retropie.pkg" -not -name "*.pck" -not -type d)"

    if isPlatform "arm"; then
        cmd+=" -f"
    fi

    addPort "$md_id" "murtop" "murtop" "$cmd"
}
