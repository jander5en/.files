
############################################################
# Minimal, plugin-free Zsh configuration
# Catppuccin Mocha: Powerline prompt + vi-mode + git + file colors
############################################################

########################
# Core options
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
# Enable vi mode
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
# Git info (branch + dirty/clean)
########################
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b'

GIT_INFO=""

function git_status_symbol() {
  git diff --quiet --ignore-submodules HEAD 2>/dev/null
  [[ $? -eq 1 ]] && echo "%F{$FG_ORANGE}●%f" || echo "%F{$FG_GREEN}✔%f"
}

########################
# Vi-mode indicator
########################
VI_MODE_PROMPT="%F{$FG_GREEN}%K{$BG_ALT} I %f%k"

function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    VI_MODE_PROMPT="%F{$FG_MAGENTA}%K{$BG_ALT} N %f%k"
    echo -ne '\e[1 q'   # block cursor
  else
    VI_MODE_PROMPT="%F{$FG_GREEN}%K{$BG_ALT} I %f%k"
    echo -ne '\e[5 q'   # beam cursor
  fi
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init {
  VI_MODE_PROMPT="%F{$FG_GREEN}%K{$BG_ALT} I %f%k"
  echo -ne '\e[5 q'
  zle reset-prompt
}
zle -N zle-line-init

########################
# Powerline prompt (2 lines)
########################
RIGHT_ARROW="☭"

PROMPT='%F{$FG_BLUE}%n@%m%f %F{$FG_CYAN}%~%f ${GIT_INFO}
${VI_MODE_PROMPT} %F{$FG_GREEN}❯ %f'

function precmd {
  vcs_info
  if [[ -n $vcs_info_msg_0_ ]]; then
    GIT_INFO="%F{$FG_RED}${RIGHT_ARROW}%f %F{$FG_MAGENTA}${vcs_info_msg_0_}%f $(git_status_symbol)"
  else
    GIT_INFO=""
  fi
}

########################
# File colors (LS_COLORS)
########################
# Catppuccin Mocha palette
eval "$(dircolors -b ~/.files/zsh/dircolors_mocha)"
export LS_COLORS

########################
# bat (syntax highlighting)
########################
export BAT_THEME=mocha

########################
# fzf preview colors
########################
export FZF_DEFAULT_OPTS="
--color=fg:#cdd6f4,bg:#1e1e2e,hl:#f5c2e7
--color=fg+:#94e2d5,bg+:#181825,hl+:#f38ba8
"

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
alias ll='ls -lh --color=auto'
alias la='ls -la --color=auto'
alias ls='ls --color=auto'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias vim='nvim'

# For fuzzy completion and keybindings
#source <(fzf --zsh)

############################################################
# End of file
############################################################


#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
