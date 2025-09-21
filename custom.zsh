####################################################
# 環境
####################################################

# zshrcの読み込み（フォールバック付き）
if [[ -f "$HOME/.zshrc" ]]; then
    source "$HOME/.zshrc"
elif [[ -f "$HOME/.config/zsh/.zshrc" ]]; then
    source "$HOME/.config/zsh/.zshrc"
else
    echo "Warning: zshrc not found in ~/.zshrc or ~/.config/zsh/.zshrc"
fi

# 自作スクリプトなどのパス
export PATH="$HOME/bin:$PATH"
# brewで入れてない系のcli toolのpath
[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
# brewです。
[[ -x "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

PROMPT="%F{green}[mentor]%f $PROMPT"

####################################################
# プラグインの読み込み
####################################################

# プラグインのベースディレクトリ
PLUGIN_DIR="${ZDOTDIR:-$HOME/.temp}/plugins"

# zsh-completions (fpathに追加)
fpath=("$PLUGIN_DIR/zsh-completions/src" $fpath)

# 補完システムの初期化
autoload -U compinit
compinit -d "${ZDOTDIR:-$HOME/.temp}/zcompdump"

# zsh-autosuggestions
source "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-history-substring-search
source "$PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh"

# zsh-syntax-highlighting (最後に読み込む)
source "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

####################################################
# 付帯
####################################################

# 基本的なグロブとワイルドカード
setopt extended_glob           # 拡張グロブを使用
setopt mark_dirs               # ディレクトリマッチ時に末尾に/を付加

# 色を使用（他の設定で参照される）
autoload -Uz colors ; colors

# 入出力制御
setopt no_flow_control        # フローコントロールを無効 ctrl + qとかが使えるようになる
setopt no_clobber             # 上書きリダイレクトの禁止
setopt notify                 # bgプロセスの状態変化を即座に通知
setopt print_eight_bit        # 8bit文字を有効

####################################################
# 履歴
####################################################

# 履歴ファイルと容量
HISTFILE="${ZDOTDIR:-$HOME/.temp}/zsh_history"

HISTSIZE=10000
SAVEHIST=100000

# 履歴の動作設定
setopt histignorealldups        # 重複を表示しない
setopt share_history            # 他のターミナルと履歴を共有
setopt hist_reduce_blanks       # 余分なスペースを削除
setopt inc_append_history       # 履歴をすぐに追加
setopt hist_verify              # 履歴呼び出し後に編集可能
setopt extended_history         # タイムスタンプ付きで保存
setopt append_history           # 複数シェルからの履歴追記を安全に
setopt hist_find_no_dups        # 検索時に重複スキップ
setopt hist_ignore_space        # 先頭スペースのコマンドを保存しない
setopt hist_expire_dups_first   # 古い重複から捨てる

####################################################
# 短絡
####################################################

bindkey '^n' history-substring-search-up
bindkey '^p' history-substring-search-down

# こぴぺ
alias -g Copy=' | pbcopy'
