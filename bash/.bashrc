#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias cls='clear; fastfetch'
alias matrix='cmatrix'
alias quit='exit'
alias q='exit'

# MongoDB shortcuts
alias mongo-on='sudo systemctl start mongodb'
alias mongo-off='sudo systemctl stop mongodb'
alias mongo-status='systemctl status mongodb'
alias mongo-shell='mongosh'

export PATH=$PATH:/bin/
export WEBSTORM_JDK=/usr/lib/jvm/java-17-openjdk

fastfetch

eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_SESSION_TYPE=wayland
