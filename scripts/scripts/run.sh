#!/bin/bash
#
# This file is part of MagiskOnWSALocal.
#
# MagiskOnWSALocal is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# MagiskOnWSALocal is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with MagiskOnWSALocal.  If not, see <https://www.gnu.org/licenses/>.
#
# Copyright (C) 2023 LSPosed Contributors
#

# DEBUG=--debug
# CUSTOM_MAGISK=--magisk-custom
if [ ! "$BASH_VERSION" ]; then
    echo "Please do not use sh to run this script, just execute it directly" 1>&2
    exit 1
fi
cd "$(dirname "$0")" || exit 1

./install_deps.sh || exit 1

WHIPTAIL=$(command -v whiptail 2>/dev/null)
DIALOG=$(command -v dialog 2>/dev/null)
DIALOG=${WHIPTAIL:-$DIALOG}
function Radiolist {
    declare -A o="$1"
    shift
    if ! $DIALOG --nocancel --radiolist "${o[title]}" 0 0 0 "$@" 3>&1 1>&2 2>&3; then
        echo "${o[default]}"
    fi
}

function YesNoBox {
    declare -A o="$1"
    shift
    $DIALOG --title "${o[title]}" --yesno "${o[text]}" 0 0
}

function DialogBox {
    declare -A o="$1"
    shift
    $DIALOG --title "${o[title]}" --msgbox "${o[text]}" 0 0
}
intro="Welcome to MagiskOnWSALocal fork by @MustardChef!

    With this utility, you can integrate Magisk for WSA easily.
    Use arrow keys to navigate, and press space to select.
    Press enter to confirm. 
"
DialogBox "([title]='Intro to MagiskOnWSA' \
            [text]='$intro')"

ARCH=$(
    Radiolist '([title]="Build arch"
                [default]="x64")' \
        'x64' "X86_64" 'on' \
        'arm64' "AArch64" 'off'
)

RELEASE_TYPE=$(
    Radiolist '([title]="WSA release type"
                [default]="retail")' \
        'retail' "Stable Channel" 'on' \
        'RP' "Release Preview Channel" 'off' \
        'WIS' "Insider Slow/ Beta Channel" 'off' \
        'WIF' "Insider Fast/ Dev Channel" 'off' \
        'latest' "WSA Preview Program Channel" 'off'
)

CUSTOM_MODEL=$(
    Radiolist '([title]="Select Device Model" \
                [default]="redfin")' \
        'none' "Windows Subsystem For Android" 'off' \
        'sunfish' "Google Pixel 4a" 'off' \
        'bramble' "Google Pixel 4a 5G" 'off' \
        'barbet' "Google Pixel 5a" 'off' \
        'redfin' "Google Pixel 5" 'on' \
        'bluejay' "Google Pixel 6a" 'off' \
        'oriole' "Google Pixel 6" 'off' \
        'raven' "Google Pixel 6 Pro" 'off' \
        'lynx' "Google Pixel 7a" 'off' \
        'panther' "Google Pixel 7" 'off' \
        'cheetah' "Google Pixel 7 Pro" 'off' \
        'tangorpro' "Google Pixel Tablet" 'off' \
        'felix' "Google Pixel Fold" 'off'
        
)

if (YesNoBox '([title]="Root" [text]="Do you want to Root WSA?")'); then
    ROOT_SOL=$(
        Radiolist '([title]="Root solution"
                    [default]="magisk")' \
            'magisk' "Magisk" 'on' \
            'kernelsu' "KernelSU" 'off'
    )
else
    ROOT_SOL="none"
fi

if [ "$ROOT_SOL" = "magisk" ]; then
    MAGISK_VER=$(
        Radiolist '([title]="Magisk version"
                    [default]="stable")' \
            'stable' "Stable Channel" 'on' \
            'beta' "Beta Channel" 'off' \
            'canary' "Canary Channel" 'off' \
            'debug' "Canary Channel Debug Build" 'off' \
            'delta' "Magisk Delta (By @HuskyDG)" 'off' \
            'alpha' "Magisk Alpha (By @vvb2060)" 'off'
    )
else
    MAGISK_VER=""
fi

if (YesNoBox '([title]="Install GApps" [text]="Do you want to install GApps?")'); then
    GAPPS_BRAND="MindTheGapps"
else
    GAPPS_BRAND="none"
fi

if (YesNoBox '([title]="Remove Amazon Appstore" [text]="Do you want to keep Amazon Appstore?")'); then
    REMOVE_AMAZON=""
else
    REMOVE_AMAZON="--remove-amazon"
fi


COMPRESS_FORMAT=$(
    Radiolist '([title]="Compress format"
                    [default]="7z")' \
            '7z' "7-Zip" 'on' \
            'zip' "Zip" 'off'
    )


clear
COMMAND_LINE=(--arch "$ARCH" --release-type "$RELEASE_TYPE" --root-sol "$ROOT_SOL" --gapps-brand "$GAPPS_BRAND" --custom-model "$CUSTOM_MODEL") 
CHECK_NULL_LIST=("$REMOVE_AMAZON" "$COMPRESS_OUTPUT" "$OFFLINE" "$DEBUG" "$CUSTOM_MAGISK")
for i in "${CHECK_NULL_LIST[@]}"; do
    if [ -n "$i" ]; then
        COMMAND_LINE+=("$i")
    fi
done

if [ "$MAGISK_VER" != "" ]; then
    COMMAND_LINE+=(--magisk-ver "$MAGISK_VER")
else
    COMMAND_LINE+=()
fi

if [ -n "$GAPPS_VARIANT" ]; then
    COMMAND_LINE+=(--gapps-variant "$GAPPS_VARIANT")
fi

if [ -n "$COMPRESS_FORMAT" ]; then
    COMMAND_LINE+=(--compress-format "$COMPRESS_FORMAT")
fi

echo "COMMAND_LINE=${COMMAND_LINE[*]}"
chmod +x ./build.sh
./build.sh "${COMMAND_LINE[@]}"
