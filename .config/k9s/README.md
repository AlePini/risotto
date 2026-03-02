[Doc](https://github.com/catppuccin/k9s)

Download the theme files & copy them into your k9s skins directory.
```bash
OUT="${XDG_CONFIG_HOME:-$HOME/.config}/k9s/skins"
mkdir -p "$OUT"
curl -L https://github.com/catppuccin/k9s/archive/main.tar.gz | tar xz -C "$OUT" --strip-components=2 k9s-main/dist
```
