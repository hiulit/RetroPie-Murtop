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
readonly RP_CONFIGS_PORTS_DIR="/opt/retropie/configs/ports"
readonly GAMELIST_PORTS_DIR="/opt/retropie/configs/all/emulationstation/gamelists/ports"
readonly GAMELIST_PORTS_FILE="$GAMELIST_PORTS_DIR/gamelist.xml"

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

# From https://itchio-godot-scraper.vercel.app/api/game/title/murtop
GAME_PROPERTIES=(
    "desc A fast-paced 80's arcade-style game where Dig Dug meets Bomberman."
    "developer hiulit"
    "genre Action"
    "image "$RP_CONFIGS_PORTS_DIR/$SCRIPTMODULE_NAME/thumb.png""
    "name Murtop"
    "path ./$SCRIPTMODULE_NAME.sh"
    "players 1"
    "publisher hiulit's game studio"
    "rating 4.8"
    "releasedate 20230518T000000"
)


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


function create_gamelist_file() {
  if [[ ! -f "$GAMELIST_PORTS_FILE" ]]; then
    mkdir -p "$GAMELIST_PORTS_DIR"
    touch "$GAMELIST_PORTS_FILE"
    cat > "$GAMELIST_PORTS_FILE" << _EOF_
<?xml version="1.0"?>
<gameList>
</gameList>
_EOF_
  fi
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

                # Install scriptmodule.
                cat "$SCRIPT_DIR/$SCRIPTMODULE_PATH_FILE" > "$RP_SETUP_DIR/$SCRIPTMODULE_PATH_FILE"
                chown -R "$user:$user" "$RP_SETUP_DIR/$SCRIPTMODULE_PATH_FILE"

                # Install Murtop.
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
                    exit 1
                fi

                # Install launching image.
                cp "$SCRIPT_DIR/launching.png" "$RP_CONFIGS_PORTS_DIR/$SCRIPTMODULE_NAME/launching.png"
                chown -R "$user:$user" "$RP_CONFIGS_PORTS_DIR/$SCRIPTMODULE_NAME/launching.png"

                # Install thumbnail.
                cp "$SCRIPT_DIR/thumb.png" "$RP_CONFIGS_PORTS_DIR/$SCRIPTMODULE_NAME/thumb.png"
                chown -R "$user:$user" "$RP_CONFIGS_PORTS_DIR/$SCRIPTMODULE_NAME/thumb.png"

                # Install "override.cfg".
                cp "$SCRIPT_DIR/override.cfg" "$RP_PORTS_DIR/$SCRIPTMODULE_NAME/override.cfg"

                create_gamelist_file

                # Check if the game already exists in the game list by checking the 'path'.
                # If so, update the game properties.
                # If not, create a new entry.
                if xmlstarlet sel -t -v "/gameList/game[path='./$SCRIPTMODULE_NAME.sh']" "$GAMELIST_PORTS_FILE" > /dev/null; then
                    for game_property in "${GAME_PROPERTIES[@]}"; do
                        local key
                        local value

                        key="$(echo $game_property | grep -Eo "^[^ ]+")"
                        value="$(echo $game_property | grep -Po "(?<= ).*")"

                        # If the key doesn't exist, create it.
                        # Otherwise, update it.
                        if ! xmlstarlet sel -t -v "/gameList/game[path='./$SCRIPTMODULE_NAME.sh']/$key" "$GAMELIST_PORTS_FILE" > /dev/null; then
                            xmlstarlet ed -L -s "/gameList/game[path='./$SCRIPTMODULE_NAME.sh']" -t elem -n "$key" -v "$value" "$GAMELIST_PORTS_FILE"
                        else
                            xmlstarlet ed -L -u "/gameList/game[path='./$SCRIPTMODULE_NAME.sh']/$key" -v "$value" "$GAMELIST_PORTS_FILE"
                        fi
                    done
                else
                    # Create a new <game> called "newGame".
                    xmlstarlet ed -L -s "/gameList" -t elem -n "newGame" -v "" "$GAMELIST_PORTS_FILE"

                    # Add subnodes to <newGame>.
                    for game_property in "${GAME_PROPERTIES[@]}"; do
                        local key
                        local value

                        key="$(echo $game_property | grep -Eo "^[^ ]+")"
                        value="$(echo $game_property | grep -Po "(?<= ).*")"

                        xmlstarlet ed -L -s "/gameList/newGame" -t elem -n "$key" -v "$value" "$GAMELIST_PORTS_FILE"
                    done
  
                    # Rename <newGame> to <game>.
                    xmlstarlet ed -L -r "/gameList/newGame" -v "game" "$GAMELIST_PORTS_FILE"
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

                # Uninstall Murtop.
                if [[ -d "$RP_PORTS_DIR/$SCRIPTMODULE_NAME" ]]; then
                    "$RP_SETUP_DIR/retropie_packages.sh" "$SCRIPTMODULE_NAME" remove
                fi

                if [[ "$?" -eq 0 ]]; then
                    echo
                    echo "Murtop was successfully uninstalled!"
                else
                    echo
                    echo "ERROR: Couldn't uninstall Murtop." >&2
                    exit 1
                fi

                # Uninstall scriptmodule.
                rm "$RP_SETUP_DIR/$SCRIPTMODULE_PATH_FILE"

                # Remove launching image.
                rm "$RP_CONFIGS_PORTS_DIR/$SCRIPTMODULE_NAME/launching.png"

                # Remove thumbnail.
                rm "$RP_CONFIGS_PORTS_DIR/$SCRIPTMODULE_NAME/thumb.png"

                # Delete game entry from the game list.
                xmlstarlet ed -L -d "/gameList/game[path='./$SCRIPTMODULE_NAME.sh']" "$GAMELIST_PORTS_FILE"
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
