#!/bin/zsh

#AUTO Activate Conda Environment.
#-----BEGIN----
function _conda_auto_activate() {
    if [ -e ".condaauto" ]; then
        # echo ".condaauto file found"
        ENV=$(head -n 1 .condaauto)

        # Check to see if already activated to avoid redundant activating
        if [[ $CONDA_DEFAULT_ENV == "$ENV" ]]; then
            #echo "Conda env '$ENV' already activated."
        else
            source activate $ENV
        fi
    # elif [ ! -z "$CONDA_DEFAULT_ENV" ] && [ -z "$MY_CONDA_ENV" ]; then
    #     echo "ennadhu "
    #     export MY_CONDA_ENV=1
    #     source deactivate
    #     unset MY_CONDA_ENV
    fi
}

function chpwd() {
  _conda_auto_activate
}

#--------------END----------------
