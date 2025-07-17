export XDG_CONFIG_HOME=$HOME/.config
export PATH=$HOME/.local/bin:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export EDITOR=nvim
# 终端输出中文
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
export all_proxy=socks5://127.0.0.1:7890

if [[ -f /etc/os-release ]]; then
  source /etc/os-release
  if [[ "$ID" = "ubuntu" ]]; then
    # homebrew linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # clash
    pgrep -x clash >/dev/null || ~/clash/clash -d ~/clash > /tmp/clash.log 2>&1 &
    # Qt
    export PATH=/home/ggbond/Qt/6.6.3/gcc_64/bin:$PATH
    export LD_LIBRARY_PATH=/home/ggbond/Qt/6.6.3/gcc_64/lib:$LD_LIBRARY_PATH
    export QML2_IMPORT_PATH=/home/ggbond/Qt/6.6.3/gcc_64/qml
    export QT_PLUGIN_PATH=/home/ggbond/Qt/6.6.3/gcc_64/plugins
  fi
fi

