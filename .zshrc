# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/marcello/Programs/google-cloud-sdk/path.zsh.inc' ]; then . '/home/marcello/Programs/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/marcello/Programs/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/marcello/Programs/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH=/home/marcello/.surrealdb:$PATH

function fmtcode(){
  echo "Running leptosfmt..."
  leptosfmt -r --stdin .
}

# add Pulumi to the PATH
export PATH=$PATH:/home/marcello/.pulumi/bin
source ~/.env

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(fzf --zsh)"

EXCLUDE_CLAUSE="--exclude .git --exclude .venv --exclude target --exclude .pyenv"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix $EXCLUDE_CLAUSE" 
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix $EXCLUDE_CLAUSE"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  local exclude_options=(${(z)EXCLUDE_CLAUSE})

  fd --hidden "${exclude_options[@]}" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  # Split EXCLUDE_CLAUSE into an array
  local exclude_options=(${(z)EXCLUDE_CLAUSE})

  fd --type=d --hidden "${exclude_options[@]}" . "$1"
}

source ~/.dotfile_utils/fzf-git/fzf-git.sh

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- BAT --
alias cat=bat
export BAT_THEME="Coldark-Dark"

# -- EZA (better ls) --
alias ls="eza --icons=always"

# -- Preview on Ctrl+t --

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

export PATH="$PATH:$HOME/.local/bin:$HOME/Programs/bin"
