export PATH="$HOME/bin:$PATH"
alias python=python3
alias pip=pip3
alias vim=nvim

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# setup vi style prompt editing
set -o vi

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
#export PATH

##
# Your previous /Users/thomasschnake/.bash_profile file was backed up as /Users/thomasschnake/.bash_profile.macports-saved_2021-03-22_at_15:29:32
##

# MacPorts Installer addition on 2021-03-22_at_15:29:32: adding an appropriate PATH variable for use with MacPorts.
# export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2021-03-22_at_15:29:32: adding an appropriate DISPLAY variable for use with MacPorts.
#export DISPLAY=:0
# Finished adapting your DISPLAY environment variable for use with MacPorts.

# Manually added 2021-03-23 additional path for the PKG_CONFIG_PATH
#export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"
#export PKG_CONFIG_PATH="/usr/X11/lib/pkgconfig:$PKG_CONFIG_PATH"
#export PKG_CONFIG_PATH="/usr/X11R6/lib/pkgconfig:$PKG_CONFIG_PATH"

# Manually added 2021-3-23 after installing llvm, as suggested in the installation guide.
#export PATH="/usr/local/opt/llvm/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
eval "$(zoxide init bash)"  # für Bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
