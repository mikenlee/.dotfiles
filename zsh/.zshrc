# add to the PATH variable and ensure these directories are listed before other paths to prioritize them
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# set up hjkl keys to navigate the completion menu in Zsh using complist module
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# tab-completion library
autoload -Uz compinit && compinit

# vcs_info framework for getting information from version control systems
autoload -Uz vcs_info
precmd() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
# RPROMPT='${vcs_info_msg_0_}'
# PROMPT='${vcs_info_msg_0_}%# '

# set up Git branch details into prompt
zstyle ':vcs_info:git:*' formats '%b '

# aliases for opening/loading faster
alias bp='vim ~/dotfiles/zsh/.zshrc'
alias sa='source ~/dotfiles/zsh/.zshrc;echo "ZSH aliases sourced."'

# +-------------+
# |  VI KEYMAP  |
# +-------------+

# Vi mode
bindkey -v
export KEYTIMEOUT=1  #make switch between modes quicker

# Callback for vim mode change
function zle-keymap-select () {
    # Only supported in these terminals
        if [ $KEYMAP = vicmd ]; then
            # Command mode

            # Set block cursor
            echo -ne '\e[1 q'
             elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
             echo -ne '\e[5 q'
#        else
#
#            # Set beam cursor
#            echo -ne '\e[5 q'
        fi
}

# Bind the callback
zle -N zle-keymap-select

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
##} Change cursor
##  source "/Users/admin/dotfiles/zsh/plugins/cursor_mode"

# +------------------------------+
# |  Python Virtual Environment  |
# +------------------------------+
# create virtual environment without pip, execute ensurepip's wheel directly
# https://stackoverflow.com/questions/51720909/how-to-get-python-m-venv-to-directly-install-latest-pip-version/60217751#60217751
function ve() {
    local py="python3"
    if [ ! -d ./.venv ]; then
        echo "creating venv..."
        if ! $py -m venv .venv --prompt=$(basename $PWD) --without-pip; then
            echo "ERROR: Problem creating venv" >&2
            return 1
        else
            local whl=$($py -c "import pathlib, ensurepip; whl = list(pathlib.Path(ensurepip.__path__[0]).glob('_bundled/pip*.whl'))[0]; print(whl)")
            echo "boostrapping pip using $whl"
            .venv/bin/python $whl/pip install --upgrade pip setuptools wheel
            source .venv/bin/activate
        fi
    else
        source .venv/bin/activate
    fi
}
