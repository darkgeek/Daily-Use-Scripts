#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls --color=auto -a -l -h'
alias la='ls --color=auto -a'
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
PS1='[\u@\h \W]\$ '
alias netcheck="nload -u K"
alias feh="feh -F"
export PATH=$PATH:/home/justin/bin
export EDITOR='vim'
export WINEARCH=win32

export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

alias connectlabfs='sudo mount -t cifs //10.1.16.251/Common /media/disk/ -o username=server-603'

fortune | cowsay
