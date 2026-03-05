if [[ -f /etc/os-release ]]; then
  source /etc/os-release
  if [[ "$ID" = "ubuntu" ]]; then
    # clash
    pgrep -x clash >/dev/null || ~/clash/clash -d ~/clash > /tmp/clash.log 2>&1 &
    # Qt
    export PATH=/home/ggbond/Qt/6.6.3/gcc_64/bin:$PATH
    export LD_LIBRARY_PATH=/home/ggbond/Qt/6.6.3/gcc_64/lib:$LD_LIBRARY_PATH
    export QML2_IMPORT_PATH=/home/ggbond/Qt/6.6.3/gcc_64/qml
    export QT_PLUGIN_PATH=/home/ggbond/Qt/6.6.3/gcc_64/plugins
  fi
fi
