# clash
pgrep -x clash >/dev/null || ~/clash/clash -d ~/clash > /tmp/clash.log 2>&1 &
source ~/.config/zsh/env.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/vi.zsh

export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"

# Qt
export PATH=/home/ggbond/Qt/6.6.3/gcc_64/bin:$PATH
export LD_LIBRARY_PATH=/home/ggbond/Qt/6.6.3/gcc_64/lib:$LD_LIBRARY_PATH
export QML2_IMPORT_PATH=/home/ggbond/Qt/6.6.3/gcc_64/qml
export QT_PLUGIN_PATH=/home/ggbond/Qt/6.6.3/gcc_64/plugins

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh


# homebrew linux
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
