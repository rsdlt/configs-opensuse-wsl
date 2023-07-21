# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

test -s ~/.alias && . ~/.alias || true

# Open Clion
alias clion="cmd.exe /mnt/c/Users/rsato/AppData/Local/JetBrains/Toolbox/scripts/clion.cmd"

# jekyll
alias jekyll="/usr/bin/jekyll.ruby3.2"

# cargo 
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias c="clear"

export TERM='xterm-256color'
export EDITOR='nvim'
export VISUAL='nvim'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH


# start starship
eval "$(starship init bash)"
. "$HOME/.cargo/env"

# start fish
# fish





