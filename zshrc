#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

fpath=(
    $HOME/.zfunc
    /usr/local/share/zsh-completions
    $fpath
)

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

path=(
    "$HOME/.bin"
    "$HOME/.local/bin"
    /usr/local/{bin,sbin}
    $path
)

if [[ -a "${ZDOTDIR:-$HOME}/.aliasrc" ]]; then
    source "${ZDOTDIR:-$HOME}/.aliasrc"
fi

if [[ -a "${ZDOTDIR:-$HOME}/.zshrc.local" ]]; then
    source "${ZDOTDIR:-$HOME}/.zshrc.local"
fi

function tox {
    if [[ -z "$TOX_PATH" && $(type -p pyenv) ]]; then
        for pyv in $(pyenv versions --bare); do
            TOX_PATH="$TOX_PATH:$(pyenv prefix $pyv)/bin"
        done
    fi

    export TOX_PATH=$TOX_PATH

    env PATH=$TOX_PATH:$PATH tox $@
}
