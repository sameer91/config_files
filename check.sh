#!/bin/bash
GDIR="$HOME/Code/config_files"
source_dir=("$HOME/.vim/vimrc"
            "$HOME/.zshrc"
            #"$HOME/.config/i3/config"
            "$HOME/.emacs.d/init.el"
            "$HOME/.emacs.d/init.el\~"
           )
dest_dir=("./vim_rc/vimrc"
          "./zshrc/zshrc"
          #"./i3_setup/i3/config"
          "./emacs.d/init.el"
          "./emacs.d/init.el\~"
         )

for i in ${!source_dir[*]}; do
    if ! diff ${source_dir[$i]} ${dest_dir[$i]} > /dev/null 2>&1
    then
        while true; do
            yn="Y";
            read -p "Update `basename ${source_dir[$i]}`? [Y/n] " yn
            case ${yn:-Y} in
                [Yy]* ) cp ${source_dir[$i]} ${dest_dir[$i]};
                        echo "Done." `basename ${source_dir[$i]}`;
                        break;;
                [Nn]* ) break;;
                * ) echo "yes or no???";;
            esac
        done
    else
        echo "No changes in" `basename ${source_dir[$i]}`
    fi
done
