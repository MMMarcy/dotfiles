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
