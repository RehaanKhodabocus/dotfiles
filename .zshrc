fastfetch
eval "$(starship init zsh)"


# Aliases
alias ls="eza -l --icons"
alias la='eza -la --icons'
alias v="nvim ."
alias ff="fastfetch"
alias lt='eza -a --tree --level=1 --icons=always'
alias cat="bat --theme base16"

# Alias Shortcuts
alias ..="cd .."
alias c="clear"
alias e="exit"
alias v="nvim ."
alias vim="nvim"
alias ip="ipconfig getifaddr en0"
function mkcd () { mkdir -p "$@" && eval cd "\"\$$#\""; }



# Git Shortcuts
alias g="git"
alias gs="git status"
alias ga="git add"
alias gp="git push"
alias gc="git clone"
alias lg="lazygit"
alias gb="git branch"

export PATH="$HOME/.local/bin:$PATH"

eval "$(zoxide init zsh)"
