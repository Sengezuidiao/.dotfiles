# Linux 专属 Qt/clash 配置，默认关闭。
# 需要在 Linux 上启用时：export DOTFILES_LINUX_QT=1 后再开新 shell（或在 .zshenv 里常设）。
: ${DOTFILES_LINUX_QT:=0}
if (( DOTFILES_LINUX_QT )); then
  # clash
  pgrep -x clash >/dev/null || ~/clash/clash -d ~/clash > /tmp/clash.log 2>&1 &
  # Qt 6.6.3
  export PATH=/home/ggbond/Qt/6.6.3/gcc_64/bin:$PATH
  export LD_LIBRARY_PATH=/home/ggbond/Qt/6.6.3/gcc_64/lib:$LD_LIBRARY_PATH
  export QML2_IMPORT_PATH=/home/ggbond/Qt/6.6.3/gcc_64/qml
  export QT_PLUGIN_PATH=/home/ggbond/Qt/6.6.3/gcc_64/plugins
fi
