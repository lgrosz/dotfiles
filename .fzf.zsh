# Setup fzf
# ---------
if [[ ! "$PATH" == */home/logan/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/logan/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/logan/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/logan/fzf/shell/key-bindings.zsh"
