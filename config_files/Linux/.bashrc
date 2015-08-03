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
#PS1='[\u@\h \W]\$ '
alias netcheck="nload -u K"
alias feh="feh -F"
export EDITOR='vim'
export WINEARCH=win32
export PATH=$PATH:$HOME/Apps/bin

export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

alias connectlabfs='sudo mount -t cifs //10.1.16.251/Common /media/disk/ -o username=server-603'
alias startnet='sudo pppoe-start && sleep 2 && sudo ntpdate time.nist.gov'
alias mygputemp='/opt/vc/bin/vcgencmd measure_temp'
alias mycputemp='cat /sys/class/thermal/thermal_zone0/temp'

# Bind Ctrl-Left and Ctrl-Right to word jumping in line editing
bind '"\e[1;5D": shell-backward-word'
bind '"\e[1;5C": shell-forward-word'

fortune | cowsay
