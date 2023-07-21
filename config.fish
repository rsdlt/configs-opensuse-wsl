if status is-interactive
    # Commands to run in interactive sessions can go here
    if not set -q TMUX
        set -g TMUX tmux new-session -d -s base
        eval $TMUX
        tmux attach-session -d -t base
    end
end

# add Rust to path 
set PATH $HOME/.cargo/bin $PATH

# function fish_greeting
#     echo $USER@$HOSTNAME - (set_color yellow; date '+%T // %A, %d %B %Y'; set_color normal)
# end

set -Ux TERM xterm-256color
set -Ux EDITOR nvim

alias e "exit"
alias cl "clear"
alias cr "cargo run -q"
alias ct "cargo test"
alias ctnc "cargo test -- --nocapture"
alias cb "cargo build"
alias cch "cargo check"
alias cat "bat"
alias neovim "nvim"
alias nv "nvim"


starship init fish | source
