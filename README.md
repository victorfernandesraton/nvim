# raton.dev nvim config

Based on ThePrimeagen video and adapted for python devs
- [Neovim Starter Kit for Python - Nerd Signals](https://www.youtube.com/watch?v=jWZ_JeLgDxU)
- [0 to LSP : Neovim RC From Scratch](https://www.youtube.com/watch?v=w7i4amO_zaE)
- [How I Setup Neovim To Make It AMAZING in 2024: The Ultimate Guide -  Josean Martinez](https://yewtu.be/watch?v=6pAG3BHurdM&listen=false)

## Prerequisites
- Fonts:
    - [MesloLGS NF Regular.ttf](
       https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
    - [MesloLGS NF Bold.ttf](
       https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
    - [MesloLGS NF Italic.ttf](
       https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
    - [MesloLGS NF Bold Italic.ttf](
       https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)
    - [Nerd Font](https://www.nerdfonts.com/) - Alternativwe to MesloLGS witch i use by default
- [True Color Terminal](https://gist.github.com/kurahaupo/6ce0eaefe5e730841f03cb82b061daa2#now-supporting-true-color) - Make Neovim look pretty
- [Neovim](https://neovim.io/) - Version 0.9 or later
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Needed for Telescope Fuzzy Finder
- [xclip](https://linuxconfig.org/how-to-use-xclip-on-linux) - Needed for system clipboard support
- [Python](https://www.python.org/) - Version 3.8 or later
- [FZF for telescope things](https://github.com/junegunn/fzf)
- [Clang compiler (if you using debian or ubuntu)](https://packages.debian.org/bookworm/clang)
- [Rust compiler](https://www.rust-lang.org)

## Getting start


### Instalation
1. Clone this repop
2. Copy and create a symlink for this folder using something like:
```bash
ln -s $(pwd) ~/.config/nvim
```

3. Open neovim in your CLI and await for mason and lazy due your magic 
4. Inside neovim using command to Install pylsp dependencies using `:PylspInstall <package-name>`
```bash
:PylspInstall pylsp-mypy
```

## Troubleshoting
- Some error in fzf:
telescope and fzf may not have installed correctly, using make in ❯ ~/.local/share/nvim/lazy/telescope-fzf-native.nvim/ to build these native plugin

