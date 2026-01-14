############################################################
# Minimal, plugin-free Zsh config
# Vi-mode + Powerline-style prompt + Git status
# Catppuccin Mocha colors (matches Neovim my_mocha)
############################################################

########################
# Basics
########################
export LANG=en_US.UTF-8
export TERM=xterm-256color
setopt PROMPT_SUBST
setopt AUTO_CD
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

########################
# Vi keybindings
########################
bindkey -v
export KEYTIMEOUT=1
bindkey '^?' backward-delete-char

########################
# Catppuccin Mocha colors
########################
BG="#1e1e2e"
BG_ALT="#181825"

FG="#cdd6f4"
FG_GRAY="#585b70"
FG_RED="#f38ba8"
FG_GREEN="#a6e3a1"
FG_YELLOW="#f9e2af"
FG_BLUE="#89b4fa"
FG_MAGENTA="#f5c2e7"
FG_CYAN="#94e2d5"
FG_ORANGE="#fab387"

# Set terminal background
echo -ne "\e]11;${BG}\a"

########################
# Cursor shape by vi mode
########################
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne '\e[1 q'   # block cursor
  else
    echo -ne '\e[5 q'   # beam cursor
  fi
}
zle -N zle-keymap-select
echo -ne '\e[5 q'

########################
# Git info (branch + status)
########################
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git:*' actionformats '%b'

function git_status_symbol() {
  git diff --quiet --ignore-submodules HEAD 2>/dev/null
  if [[ $? -eq 1 ]]; then
    echo "%F{$FG_ORANGE}●%f"
  else
    echo "%F{$FG_GREEN}✔%f"
  fi
}

########################
# Vi-mode indicator
########################
function vi_mode_prompt() {
  if [[ $KEYMAP == vicmd ]]; then
    echo "%F{$FG_MAGENTA}%K{$BG_ALT} N %f%k"
  else
    echo "%F{$FG_GREEN}%K{$BG_ALT} I %f%k"
  fi
}

########################
# Powerline-style prompt (2 lines)
########################
RIGHT_ARROW=""

function powerline_prompt() {
  # ---- line 1 ----
  PROMPT="%F{$FG_BLUE}%n@%m%f "
  PROMPT+="%F{$BG_ALT}${RIGHT_ARROW}%f "
  PROMPT+="%F{$FG_CYAN}%~%f"

  if [[ -n ${vcs_info_msg_0_} ]]; then
    PROMPT+=" %F{$BG_ALT}${RIGHT_ARROW}%f "
    PROMPT+="%F{$FG_MAGENTA}${vcs_info_msg_0_}%f "
    PROMPT+="$(git_status_symbol)"
  fi

  # ---- line break ----
  PROMPT+=$'\n'

  # ---- line 2 ----
  PROMPT+="$(vi_mode_prompt) "
  PROMPT+="%F{$FG_GREEN}❯ %f"
}

precmd() {
  vcs_info
  powerline_prompt
}

########################
# Completion
########################
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

########################
# Aliases
########################
alias ll='ls -lh'
alias la='ls -la'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'

############################################################
# End of file
############################################################

