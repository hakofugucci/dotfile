# dotfile

My personal dotfiles for <zsh / nvim / macos27, nixos>.
## description
macos, nixos向けの個人的なdotfilesです。
home-manager, flakeを
nix-darwin, determinate-nixとnixosによって管理することで再現性を確保しています。
力を入れている部分はzsh, nvim周りです。
~/dotfile にcloneしてください。（nixがこのパスを参照）
nixを使用できることが前提です。nixのインストールは割愛します。

## 構成
|パス|内容|
|---|---|
|'common/'|mac,linux共通設定|
|'mac/, linux/'|それぞれmacとlinuxのos別設定|
|'rice/'|linuxのrice用設定(WIP)|
|'home/'|nixのパッケージ、dotfile周り|
|'host/'|nixos,darwin-nixの設定|

## インストール

macosのインストール方法です。
nixosも可能ですが、ここには記述しません。
また、hosts/nixos/hardware-configuration.nixの使用も推奨しません。
> 既存の設定は上書きされる可能性があります。事前にバックアップを取ってください。

```bash
git clone https://github.com/hakofugucci/dotfile.git ~/dotfile
cd ~/dotfile

# 初回（macのみ/nix-darwin未導入の場合)
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#<hostname>

# 更新
sudo darwin-rebuild switch --flake ~/dotfile
```

macでは`<hostname>` は `flake.nix` の `darwinConfigurations` に定義した名前です。
自分の環境で試す場合は、hosts/darwin/configuration.nixと
このコマンドのホスト名・ユーザー名を書き換えてください。

### 手動で必要なもの
- GitHubのアクセストークン（~/.config/nix/nix.conf の access-tokens）
- アクセシビリティ権限（skhd, yabai など）

## 参考にしたもの

theme:https://github.com/folke/tokyonight.nvim

## issueについて

質問など歓迎です！

## License

[MIT](./LICENSE)
