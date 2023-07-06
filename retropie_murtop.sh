#!/usr/bin/env bash
# retropie-murtop.sh
#
# RetroPie Murtop
# A script to install Murtop on RetroPie.
#
# Author: hiulit
# Repository: https://github.com/hiulit/RetroPie-Murtop
# License: MIT https://github.com/hiulit/RetroPie-Murtop/blob/master/LICENSE)

# Globals ####################################################################

user="$SUDO_USER"
[[ -z "$user" ]] && user="$(id -un)"

home="$(eval echo ~$user)"

readonly RP_DIR="$home/RetroPie"
readonly RP_PORTS_DIR="/opt/retropie/ports"

readonly SCRIPT_VERSION="1.0.0"
readonly SCRIPT_DIR="$(cd "$(dirname $0)" && pwd)"
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_FULL="$SCRIPT_DIR/$SCRIPT_NAME"
readonly SCRIPT_TITLE="RetroPie Murtop"
readonly SCRIPT_DESCRIPTION="A script to install Murtop on RetroPie."

readonly SCRIPTMODULE_NAME="murtop"
readonly SCRIPTMODULE_PATH_FILE="scriptmodules/ports/$SCRIPTMODULE_NAME.sh"

readonly GAME_BIN_DIR="$SCRIPT_DIR/bin"


# Variables ##################################################################

RP_SETUP_DIR="$home/RetroPie-Setup"


# Functions ##################################################################

function is_sudo() {
    [[ "$(id -u)" -eq 0 ]]
}


function is_retropie() {
    [[ -d "$RP_DIR" && -d "$home/.emulationstation" && -d "/opt/retropie" ]]
}


function check_retropie_setup_dir_path() {
    if [[ -n "$1" ]]; then
        if [[ -d "$1" ]]; then
            RP_SETUP_DIR="$1"
        else
            echo "ERROR: '$1' doesn't exist!" >&2
            exit 1
        fi
    fi
}


function usage() {
    echo "USAGE: sudo $0 [OPTIONS]"
    echo
    echo "Use 'sudo $0 --help' to see all the options."
}


function get_options() {
    if [[ -z "$1" ]]; then
        usage
        exit 0
    else
        case "$1" in
#H -h, --help               Prints the help message.
            -h|--help)
                echo "$SCRIPT_TITLE"
                for ((i=1; i<="${#SCRIPT_TITLE}"; i+=1)); do [[ -n "$dashes" ]] && dashes+="-" || dashes="-"; done && echo "$dashes"
                echo "$SCRIPT_DESCRIPTION"
                echo
                echo "USAGE: sudo $0 [OPTIONS]"
                echo
                echo "OPTIONS:"
                echo
                sed '/^#H /!d; s/^#H //' "$0"
                exit 0
                ;;
#H -i, --install [path]     Installs Murtop on RetroPie.
#H                              Path: The location of the "RetroPie-Setup" folder.
#H                              Default: "~/RetroPie-Setup".
            -i|--install)
                check_retropie_setup_dir_path "$2"
                cat "$SCRIPT_DIR/$SCRIPTMODULE_PATH_FILE" > "$RP_SETUP_DIR/$SCRIPTMODULE_PATH_FILE"
                "$RP_SETUP_DIR/retropie_packages.sh" "$SCRIPTMODULE_NAME"

                if [[ "$?" -eq 0 ]]; then
                    echo
                    echo "Murtop was successfully installed!"
                    echo
                    echo "############################################################"
                    echo " __  __            _              "
                    echo "|  \/  |_   _ _ __| |_ ___  _ __  "
                    echo "| |\/| | | | | '__| __/ _ \| '_ \ "
                    echo "| |  | | |_| | |  | || (_) | |_) |"
                    echo "|_|  |_|\__,_|_|   \__\___/| .__/ "
                    echo "                           |_|    "
                    echo
                    echo "A fast-paced 80's arcade game where Dig Dug meets Bomberman."
                    echo
                    echo "Help Murti save the world from an invasion of"
                    echo "carrot-hungry moles with her bomb-pooping skills!"
                    echo
                    echo "A game by hiulit © 2023"
                    echo
                    echo "############################################################"
                else
                    echo
                    echo "ERROR: Couldn't install Murtop." >&2
                fi
                ;;
#H -u, --uninstall [path]   Uninstalls Murtop on RetroPie.
#H                              Path: The location of the "RetroPie-Setup" folder.
#H                              Default: "~/RetroPie-Setup".
            -u|--uninstall)
                check_retropie_setup_dir_path "$2"

                if [[ ! -f "$RP_SETUP_DIR/$SCRIPTMODULE_PATH_FILE" ]]; then
                    echo "Can't uninstall Murtop because it is not installed."
                    exit 1
                fi

                if [[ -d "$RP_PORTS_DIR/$SCRIPTMODULE_NAME" ]]; then
                    "$RP_SETUP_DIR/retropie_packages.sh" "$SCRIPTMODULE_NAME" remove
                fi

                rm "$RP_SETUP_DIR/$SCRIPTMODULE_PATH_FILE"

                if [[ "$?" -eq 0 ]]; then
                    echo
                    echo "Murtop was successfully uninstalled!"
                else
                    echo
                    echo "ERROR: Couldn't uninstall Murtop." >&2
                fi
                ;;
#H -v, --version            Prints the script version.
            -v|--version)
                echo "$SCRIPT_VERSION"
                ;;
            *)
                echo "ERROR: Invalid option '$1'." >&2
                exit 2
                ;;
        esac
    fi
}


function main() {
    if ! is_sudo; then
        echo "The script must be run under sudo." >&2
        echo >&2
        usage
        exit 1
    fi
 
    if ! is_retropie; then
        echo "RetroPie is not installed. Aborting ..." >&2
        exit 1
    fi

    get_options "$@"
}

main "$@"
