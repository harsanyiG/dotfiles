# vim mode
bindkey -v
export KEYTIMEOUT=1 

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)


# add git info
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# default editor (for lf, etc...)
export EDITOR=nvim

# promt stuff
COLOR_DEF=$'%f'
COLOR_USR=$'%F{51}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '

neofetch 


#alias
alias dot='cd ~/dotfiles'
alias v='nvim'
