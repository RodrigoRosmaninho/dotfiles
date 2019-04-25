# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/rrosmaninho/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



#############
## ALIASES ##
#############

alias idlew="/home/rrosmaninho/Downloads/IdleWork/work"
alias todo="todoist --color"
alias fixquartus='/opt/altera/18.1/quartus/bin/jtagconfig'
alias config='/usr/bin/git --git-dir=/home/rrosmaninho/.cfg/ --work-tree=/home/rrosmaninho'
alias c='ccompile'
alias miect='cd ~/Repos/miect-stuff/'

#############
##  PATH   ##
#############

export PATH=$PATH:/home/rrosmaninho/.gem/ruby/2.6.0/bin
export CLASSPATH=".:/usr/local/lib/antlr-4.7.2-complete.jar:$CLASSPATH"
export ANTLR4_PATH="/usr/local/lib"
alias mem="sudo smem -t -k -c pss -P"
alias bwl="bw lock && echo -n 'nothing here' | xclip -se c"
if [ -d /opt/pic32mx/bin ] ; then
  export PATH=$PATH:/opt/pic32mx/bin
fi

########################
##  USEFUL FUNCTIONS  ##
########################

ccompile() {
    cc -Wall "$1" -o "${1%.*}" -lm
    if [ "$?" -ne 0 ] ; then
      return 1
    fi
    set -- "${1%.*}" "${@:2}"
    ./"$@"
    rm "$1"
}

detpic() {
	# r.rosmaninho@ua.pt
	if [ ! -f $1 ]; then
		printf "\nO ficheiro \"$1\" nao existe!\n"
		return 1
	fi
	if [[ ! $1 = *.hex ]]; then
		pcompile $1
		if [ "$?" != 0 ]; then
	  		return 2
		fi
	fi
	i=-1
	done=0
	for i in $(ls /dev | grep ttyUSB); do
	   	 ldpic32 "${1%.*}.hex" -p "/dev/$i"
	   	 if [ "$?" = 0 ] ; then
	   	 	done=1
	   	 	break
	   	 fi
	done
	if [ $done = 1 ]; then
		pterm -p "/dev/$i"
		return 0
	else
		printf "\nNao foi possivel encontrar a DETPIC :(\n"
		return 3
	fi
}

mkcd()  {
  mkdir $1
  cd $1
}

# BitWarden CLI Session Management
bwu() {
  # ¯\_(ツ)_/¯
  bw unlock | tee >(cat > file)
  string=$(cat file)
  searchstring="--session "
  export BW_SESSION="${string#*$searchstring}"
  rm file
  string="nothing here"
  clear
}

bwg() {
  string=$(bw get "$@")
  echo -n "${string}" | xclip -se c
  string="nothing here"
}

############
##  MISC  ##
############

source ~/.profile


export PATH=$PATH:/usr/bin

#source '/usr/lib/azure-cli/az.completion'
