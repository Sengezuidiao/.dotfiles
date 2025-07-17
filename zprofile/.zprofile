eval "$(/opt/homebrew/bin/brew shellenv)"
export QT6_DIR="$HOME/Qt/6.9.1/macos"
export PATH="$QT6_DIR/bin:$PATH"
export CMAKE_PREFIX_PATH="QT6_DIR:$CMAKE_PREFIX_PATH"
