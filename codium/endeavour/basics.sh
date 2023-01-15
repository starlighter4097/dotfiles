#!/bin/bash

baseinstall(){

sudo pacman -S base-devel
sudo pacman -S rofi dmenu sxhkd redshift network-manager-applet vim kitty ttf-firacode-nerd --noconfirm
sudo pacman -S fcron --noconfirm
sudo systemctl start fcron # systemctl enable if required
sudo pacman -S --noconfirm zsh powerline-fonts

# cron shell runs non interactive thats why error , add bash -l -c and works fine

}


importdotfiles() {

    cd
    rm -rf dotfiles
    git clone 


}


chsh() {

    #    yay -S zsh oh-my-zsh-git nerd-fonts-hack
    sudo chsh -s /bin/zsh

    mkdir -p .config/zsh
    touch .config/zsh/zsh_{func,alias,themes}
    curl -fsSL https://raw.githubusercontent.com/AmarjithTK/dotfiles/dwm-endeavour/zsh-extras-config >>~/.zshrc
    echo -e " press y to reinstall old alias, any other key to skip\n"
    read y
    if [[ $y == "y" ]]; then
        curl -fsSL https://raw.githubusercontent.com/AmarjithTK/dotfiles/dwm-endeavour/.zsh_extras >>~/.config/zsh/zsh_alias
    fi

    curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    #    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

    echo 'source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme' >>~/.config/zsh/zsh_themes
    p10k configure

}

function yayinstall() {
    cd
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd
}

function aurinstall() {

    yay -S google-chrome vscodium-bin

}

function appimageinstaller() {

    mkdir -p ~/.local/bin/appimages

}

function redshifter() {
    mkdir -p .local/bin
    cd ~/.local/bin
    curl -o redshifter https://raw.githubusercontent.com/wizetek/bash/master/redshifter
    chmod +x redshifter
    cd
}

function firacodeorfont() {

    echo "Enter a font link or choose default by pressing d \n"
    read FONT
    if [[ $FONT == 'd' ]]; then
        wget -o https://fonts.google.com/download?family=Fira%20Code
    fi

    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts

    fc-cache -f
    clear
    cd

}

function dwminstall() {
    cd
    pacman -S --needed git base-devel

    git clone https://github.com/AmarjithTK/dwm.git -b dwm-endeavour --single-branch --depth 1

    cd dwm

    sudo make clean install
    sudo cp dwm.desktop /usr/share/xsessions/
    cd slstatus

    sudo make clean install
    cd

}

gitconfig() {

    git config --global user.name "AmarjithTK"
    git config --global user.email "amarjithraveendran@gmail.com"
}

function choicerunner() {

    echo -e "Enter your choice \n1)Base install \n2)yayinstall \n3)redshifter \n4)chshell \n5)dwminstall \n6) aurinstall \ngitconfig"
    echo -e "\n Press q to quit"
    read CHOICE
    if [[ $CHOICE == 'q' ]]; then
        echo "Exiting ....."
        exit 1
    fi

    case "$CHOICE" in

    1)
        echo "base install ... \n"
        baseinstall
        echo -e "\ndone ...................\n"
        ;;

    2)
        echo "yay ... \n"
        yayinstall
        echo -e "\ndone ...................\n"
        ;;
    3)
        echo "redshifter ... \n"
        redshifter
        echo -e "\ndone ...................\n"
        ;;
    4)
        echo "chshell ... \n"
        chsh
        echo -e "\ndone ...................\n"
        ;;
    5)
        echo "dwminstall ... \n"
        dwminstall
        echo -e "\ndone ...................\n"
        ;;
    6)
        echo "aur install ... \n"
        aurinstall
        echo -e "\ndone ...................\n"
        ;;
    7)
        echo "dwminstall ... \n"
        dwminstall
        echo -e "\ndone ...................\n"
        ;;
    *)
        echo "Wrong choice, exiting ..."
        echo -e "\ndone ...................\n"
        exit 1
        ;;

    esac

}

while true; do
    choicerunner
done