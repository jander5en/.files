# --- Basics -------------------------------------------------
export ZDOTDIR="$HOME"
setopt PROMPT_SUBST
setopt AUTO_CD
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# --- Completion --------------------------------------------
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# --- Aliases ------------------------------------------------
alias ll='ls -lh'
alias la='ls -la'
alias gs='git status'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'

# --- Keybindings - vim mode ---------------------------------
bindkey -v
#function to select cursor depending if it is in n or i mode
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne '\e[1 q'   # block cursor (normal)
  else
    echo -ne '\e[5 q'   # beam cursor (insert)
  fi
}
zle -N zle-keymap-select

echo -ne '\e[5 q'  # start in insert mode

export KEYTIMEOUT=1


# --- Prompt -------------------------------------------------
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%b)'

setopt PROMPT_SUBST
PROMPT='%F{blue}%n@%m%f %F{cyan}%~%f %F{magenta}${vcs_info_msg_0_}%f
%F{green}❯ %f'

# --- Built-in highlighting ---------------------------------
autoload -Uz colors && colors

# --- Colors -------------------------------------------------
eval "$(dircolors -b)"

# --- true color support -------------------------------------
export TERM=xterm-256color   # or your terminal default

# --- Catppuccin colors -------------------------------------
autoload -Uz colors && colors

# Use hexadecimal colors
FG_BG="#cdd6f4:#1e1e2e"
FG_NORMAL="#cdd6f4"
FG_GRAY="#585b70"
FG_RED="#f38ba8"
FG_GREEN="#a6e3a1"
FG_YELLOW="#f9e2af"
FG_BLUE="#89b4fa"
FG_MAGENTA="#f5c2e7"
FG_CYAN="#94e2d5"
FG_ORANGE="#fab387"
BG="#1e1e2e"
BG_ALT="#181825"
echo -ne "\e]11;${BG}\a"
# --- Prompt with Catppuccin colors --------------------------
autoload -Uz vcs_info
precmd() { vcs_info }

# Git branch format
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git

# Mode indicator for vi-mode
function vi_mode_prompt() {
  [[ $KEYMAP == vicmd ]] && echo "%F{$FG_MAGENTA}[N]%f" || echo "%F{$FG_GREEN}[I]%f"
}

# Prompt
setopt PROMPT_SUBST
PROMPT="%F{$FG_BLUE}%n@%m%f %F{$FG_CYAN}%~%f %F{$FG_MAGENTA}${vcs_info_msg_0_}%f
$(vi_mode_prompt) ❯ "

# --- Command coloring ---------------------------------------
#ZSH_HIGHLIGHT_STYLES[command]="fg=$FG_GREEN"
#ZSH_HIGHLIGHT_STYLES[alias]="fg=$FG_CYAN"
#ZSH_HIGHLIGHT_STYLES[path]="fg=$FG_BLUE"
#ZSH_HIGHLIGHT_STYLES[builtin]="fg=$FG_MAGENTA"
#ZSH_HIGHLIGHT_STYLES[function]="fg=$FG_BLUE"
#ZSH_HIGHLIGHT_STYLES[default]="fg=$FG_NORMAL"




