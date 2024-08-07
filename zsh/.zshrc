# Enable Powerlevel10k instant prompt. Should stay at the top of ~/.zshrc.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then

  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

fi

# Fix the Java issue
export _JAVA_AWT_WM_NONREPARENTING=1


setopt histignorealldups sharehistory


# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e



# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=3000
SAVEHIST=1000
HISTFILE=~/.zsh_history


# Use modern completion system
autoload -Uz compinit
compinit



zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# Manual configuration
PATH=${PATH}:/root/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/danny2768/.cargo/bin
export PATH

# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='batcat'
alias python='python3'
alias docker-compose='docker compose'
# alias postman='postman & disown'
alias postman='postman >/dev/null 2>&1 & disown'
alias notion='notion-snap >/dev/null 2>&1 & disown'
alias notion-calendar='notion-calendar-snap >/dev/null 2>&1 & disown'
alias dbeaver='dbeaver-ce >/dev/null 2>&1 & disown'
alias docker-desktop='/opt/docker-desktop/bin/docker-desktop >/dev/null 2>&1 & disown'
alias mongo-compass='mongodb-compass >/dev/null 2>&1 & disown'
alias discord='discord >/dev/null 2>&1 & disown'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Plugins
source /home/danny2768/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-sudo/sudo.plugin.zsh


# Functions

function update-system(){
    echo -e "\e[1;33mUpdating apt packages...\e[0m" # Yellow color
    sudo apt update
    echo -e "\e[1;33mUpgrading apt packages...\e[0m" # Yellow color
    sudo apt upgrade -y
    echo -e "\e[1;33mAutoremoving apt packages...\e[0m" # Yellow color
    sudo apt autoremove
    echo -e "\e[1;33mUpdating flatpak packages...\e[0m" # Yellow color
    flatpak update -y
    echo -e "\e[1;33mRefreshing snap packages...\e[0m" # Yellow color
    sudo snap refresh
    echo -e "\e[1;33mSystem update completed.\e[0m" # Yellow color
}

function init-node-ts(){
	npm init -y
    npm i -D typescript @types/node ts-node-dev rimraf
    npx tsc --init --outDir dist/ --rootDir src
    touch docker-compose.yml
    touch .gitignore
    mkdir -p src && touch src/app.ts
    echo "/node_modules" >> .gitignore
    echo "/dist" >> .gitignore
    echo ".env" >> .gitignore

    echo -e "\e[1;33mRemember to add the following scripts to the package.json & update author.\e[0m" # Yellow color
    echo "\"dev\": \"tsnd --respawn --clear src/app.ts\",
\"build\": \"rimraf ./dist && tsc\",
\"start\": \"npm run build && node dist/app.js\""
}

function install-express (){
    npm i dotenv env-var express
    npm i -D @types/express
    touch .env
    echo "PORT=3000" >> .env
    cp .env .env.template
}

function node-testing-ts(){
    echo -e "\e[1;33mInstalling dependencies...\e[0m" # Yellow color
    npm install -D jest @types/jest ts-jest supertest
    npx jest --init

    echo -e "\e[1;33mAdd the following lines to jest.config.ts\e[0m" # Yellow color
    echo -e "preset: 'ts-jest',"
    echo -e "testEnvironment: 'jest-environment-node',"
 
    echo -e "\e[1;33mAdd the following scripts to the package.json\e[0m" # Yellow color
    echo "\"test\": \"jest\",
\"test:watch\": \"jest --watch\",
\"test:coverage\": \"jest --coverage\""

}

# Extract nmap information
# function extractPorts(){
# 	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
# 	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
# 	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
# 	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
# 	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
# 	echo $ports | tr -d '\n' | xclip -sel clip
# 	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
# 	cat extractPorts.tmp; rm extractPorts.tmp
# }


# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}


function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

# Clear screen and scrollback
function clear-history() {
  print -n "\ec"   # ESC c sequence to reset the terminal
  zle clear-screen # Call the default clear-screen action
}


# ZLE Widgets
zle -N clear-history



# Load Angular CLI autocompletion.
# source <(ng completion script)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize
source ~/powerlevel10k/powerlevel10k.zsh-theme

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
# bindkey "^[[5~" up-line-or-history
# bindkey "^[[6~" down-line-or-history

# Bind Ctrl+L to clear the terminal and scrollback history
bindkey '^k' clear-history
