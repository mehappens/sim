#!/bin/bash
# restriction: currently, this script should be run from the root project directory

function check_and_install {
    PROGRAM_NAME=$1
    INTALL_COMMAND=$2

    IS_INSTALED=`which $PROGRAM_NAME`

    if [[ -z "$IS_INSTALED" ]]; then
        echo "Not found: $PROGRAM_NAME. Installing..."
        if [[ -n "$INTALL_COMMAND" ]]; then
            eval $INTALL_COMMAND
        else
            sudo apt-get install $PROGRAM_NAME
        fi
    else
        echo "Found: $PROGRAM_NAME"
    fi
}

check_and_install "pdflatex" "sudo apt-get install texlive"

DIRNAME="/usr/share/texlive/texmf-dist/tex/latex"
if [[ -d "$DIRNAME" ]]; then
    if [[ ! -d "$DIRNAME/custom" ]]; then
        sudo mkdir $DIRNAME/custom
    fi

    if [[ ! -f "$DIRNAME/custom/usecases.sty" ]]; then
        sudo cp ./development/provision/resources/usecases.sty $DIRNAME/custom/
        sudo texhash
    fi
else
    echo "Directory /usr/share/texlive/texmf-dist/tex/latex does not exist"
fi
