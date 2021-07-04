#!/bin/bash
# Script to install dependencies such as kernel headers


NO_COLOR="\033[0m"
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

err(){
	echo -ne "${RED}${BOLD}[-] ${*}${NO_COLOR}\n" >&2
	exit 1;
}
success(){
	echo -ne "${GREEN}${BOLD}[+] ${*}${NO_COLOR}\n" >&2 
}

msg() {
    echo -e "${BLUE}${BOLD}[!] ${*}${NO_COLOR}"
}

check_install_err() {
    if [[ "$1" != 0 ]]; then
        err "Some error in install dependencies with $2"
        exit 2
    fi
}

echo -ne "\n ／ ${DARKGRAY}■${NO_COLOR} ＼~ ${CYAN}${BOLD}OwO preyring to fock another kernel${NO_COLOR}\n"
echo -ne "（ ´∀｀）"
echo -ne "\n${ORANGE}${BOLD}[!]${NO_COLOR} UwU weylcome to dependency wizayrd\n"

if [[ "$(id -u)" -ne 0 ]];then
	SUDO="$(command -v sudo 2>/dev/null)"
	DOAS="$(command -v doas 2>/dev/null)"
	if [[ -z $SUDO ]] || [[ -z $DOAS ]];then
		err "Pleyse run as r00t OwO"
	fi
fi
success "Good ur root m(__)m"

if [[ ! -z $(command -v apt-get) ]] || [[! -z $(command -v apt)]]; then
    msg "Detect apt package manager"

    $SUDO apt -y update
    $SUDO apt -y install build-essential libncurses-dev linux-headers-$(uname -r) socat

    check_install_err $? "apt"

elif [[ ! -z $(command -v apk) ]]; then
    msg "Detect apk package manager"

    $SUDO apk --update add gcc make g++ ncurses-dev linux-headers socat

    check_install_err $? "apk"
elif [[ ! -z $(command -v pacman) ]]; then
    msg "Detect pacman package manager"

    $SUDO pacman -Sy
    $SUDO pacman -S --noconfirm base-devel ncurses linux-headers socat
    check_install_err $? "pacman"
elif [[ ! -z $(command -v yum) ]]; then
    msg "Detect yum package manager"

    $SUDO yum -y install gcc gcc-c++ make ncurses-devel kernel-devel kernel-headers socat
    check_install_err $? "yum"
elif [[ ! -z $(command -v dnf) ]]; then
    msg "Detect dnf package manager"

    $SUDO dnf -y install ncurses-devel make automake gcc gcc-c++ kernel-devel kernel-headers socat
    check_install_err $? "dnf"
else
    err "Not found package manager, you need install manually the \"build-essential, libncurses-dev, socat and linux-headers\""
    exit 1
fi
