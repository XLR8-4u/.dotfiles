export ZSH="$HOME/.oh-my-zsh"

plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  git
)

source $ZSH/oh-my-zsh.sh

export PATH=$HOME/.config/rofi/scripts:$PATH
export XCURSOR_THEME=Bibata-Modern-Classic
export XCURSOR_SIZE=24  # You can adjust this size
export GIO_USE_NETWORK_MONITOR=basic

export LANG=de_DE.UTF-8
export LC_ALL=de_DE.UTF-8
export EDITOR=nvim

source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/.config/zshrc.d/dots-hyprland.zsh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:/home/mika/.spicetify
#unifetch --ascii_distro Arch --color_blocks off

#alias hz144="wlr-randr --output eDP-1 --custom-mode 1920x1080@144"
#alias hz60="wlr-randr --output eDP-1 --custom-mode 1920x1080@60"
#alias cat="bat --theme OneHalfDark "
alias ls="eza -1lxh  -F --classify=always --color=always --icons=always --no-quotes --hyperlink --group-directories-first --no-user --git -@"
alias la="eza -1oxlhA -F --classify=always --color=always --icons=always --no-quotes --hyperlink --group-directories-first --no-user"
alias s='shutdown -P'
alias b="btop"
alias ff="fastfetch -c ~/.config/fastfetch/config.jsonc"
alias nf="neofetch --disable gpu wm shell packages terminal wm_theme --cpu_speed off --cpu_cores off --distro_shorthand on --gtk2 off --gtk3 off --bold on --color_blocks off --colors 4 4 4 4 --ascii_distro arch_small --ascii_colors 4 7"
alias cls="clear && exec zsh"
alias y=yazi
alias lg=lazygit
alias peaclock="peaclock --config-dir ~/.config/peaclock"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zshrc.d/auto-Hypr.sh

# bun completions
[ -s "/home/mika/.bun/_bun" ] && source "/home/mika/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Conda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# Deno
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"

# pipx (assumes install under your user)
export PATH="$PATH:$HOME/.local/bin"

# For persistent cursor visibility across all apps
#
if [[ -z $FASTFETCH_SHOWN ]]; then
  fastfetch -c ~/.config/fastfetch/config.jsonc
  export FASTFETCH_SHOWN=1
fi
