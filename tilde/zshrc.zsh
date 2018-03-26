# Locale
export LC_ALL=en_US.UTF-8
export PROMPT_EOL_MARK=''
export LANG="en_US"

# Do not overwrite files when redirecting using ">". Note that you can still override this with ">|"
set -o noclobber

# Prepend $PATH without duplicates
function _prepend_path() {
	if ! $( echo "$PATH" | tr ":" "\n" | grep -qx "$1" ) ; then
		PATH="$1:$PATH"
	fi
}

# n, Node version manager (http://git.io/n-install-repo)
export N_PREFIX="$HOME/n"

# Construct $PATH
# 1. Default paths
# 2. ./node_modules/.bin - shorcut to run locally installed Node bins
# 3. Custom bin folder for n, Ruby, CoreUtils, dotfiles, etc.
PATH='/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:./node_modules/.bin'
[ -d "$N_PREFIX/bin" ] && _prepend_path "$N_PREFIX/bin"
[ -d /usr/local/bin ] && _prepend_path "/usr/local/bin"
[ -d /usr/local/opt/ruby/bin ] && _prepend_path "/usr/local/opt/ruby/bin"
[ -d /usr/local/opt/coreutils/libexec/gnubin ] && _prepend_path "/usr/local/opt/coreutils/libexec/gnubin"
[ -d ~/dotfiles/bin ] && _prepend_path "$HOME/dotfiles/bin"
[ -d ~/bin ] && _prepend_path "$HOME/bin"
[ -d ~/.rbenv/bin ] && _prepend_path "$HOME/.rbenv/bin:$PATH"
[ -d /Applications/calibre.app ] && _prepend_path "/Applications/calibre.app/Contents/MacOS"
export PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='code'
fi

# Make less the default pager, add some options and enable syntax highlight using source-highlight
LESSPIPE=`which src-hilite-lesspipe.sh`
[ -n "$LESSPIPE" ] && export LESSOPEN="| ${LESSPIPE} %s"
less_options=(
	# If the entire text fits on one screen, just show it and quit. (Be more
	# like "cat" and less like "more".)
	--quit-if-one-screen

	# Do not clear the screen first.
	--no-init

	# Like "smartcase" in Vim: ignore case unless the search pattern is mixed.
	--ignore-case

	# Do not automatically wrap long lines.
	--chop-long-lines

	# Allow ANSI colour escapes, but no other escapes.
	--RAW-CONTROL-CHARS

	# Do not ring the bell when trying to scroll past the end of the buffer.
	--quiet

	# Do not complain when we are on a dumb terminal.
	--dumb
);
export LESS="${less_options[*]}"
export PAGER='less'

# Terminal title
DISABLE_AUTO_TITLE="true"
function _set_terminal_title() {
	local title="$(basename "$PWD")"
	if [[ -n $SSH_CONNECTION ]]; then
		title="$title \xE2\x80\x94 $HOSTNAME"
	fi
	echo -ne "\033];$title\007"
}
precmd_functions+=(_set_terminal_title)

# Homebrew install badge: beer sucks, coffee rules
export HOMEBREW_INSTALL_BADGE='☕'

# Disable bundle for git-friendly
export GIT_FRIENDLY_NO_BUNDLE=true

# Oh My Zsh
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Theme.
ZSH_THEME="robbyrussell"
# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"
# Format of command execution time stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"
# Custom custom folder
ZSH_CUSTOM="$HOME/dotfiles/zsh"
# Plugins (see ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(extract git-extras)
source $ZSH/oh-my-zsh.sh

# Autocompletion for git-friendly
fpath=($(brew --prefix)/share/zsh/functions $fpath)
autoload -Uz _git && _git
compdef __git_branch_names branch br

# Enable zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting
[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable fzf: https://github.com/junegunn/fzf
# Use fd (https://github.com/sharkdp/fd) to respect .gitignore
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Use * instead of ** to trigger autocomletion
export FZF_COMPLETION_TRIGGER='*'
# Use fd to respect .gitignore and exclude .git directory
_fzf_compgen_path() {
  fd --hidden --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --exclude ".git" . "$1"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Rbenv
[ -d ~/.rbenv/bin ] && eval "$(rbenv init -)"

# Disable sharing history between terminals enabled by Oh My Zsh
unsetopt share_history

# Load extra (private) settings
[ -f ~/.zshlocal ] && source ~/.zshlocal
