# dotfiles
Config files for various programs that I use on many platforms. If I do not have a config file for something in my prefered setup, I use the default settings.

## My preffered setup

- Windows Terminal/Terminal Emulator: [Windows Terminal](https://github.com/microsoft/terminal) with Ubuntu WSL or [iTerm2](https://github.com/gnachman/iTerm2) for Mac

    - Font: ["MesloLGS NF"](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)

- Shell: [zsh](http://zsh.sourceforge.net/) ([+ oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh))

    **Plugins**

    - `git`

    **Theme**

    - [`"powerlevel10k"`](https://github.com/romkatv/powerlevel10k) <sup>1</sup>

- Default Editor: [vim](https://www.vim.org/)

    **Plugins**

    - [vim-plug](https://github.com/junegunn/vim-plug)

    - [NERDTree](https://github.com/preservim/nerdtree)

    - [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe)

- Node Package Manager: [nvm](https://github.com/nvm-sh/nvm)

- Fuzzy File Finder: [fzf](https://github.com/junegunn/fzf)

I've done my best to decouple these things from one another, but some dependencies remain. e.g. My p10k config requires the MesloLGS NF (or equivalent) font.

<sup>1</sup>Requires the MeslosLGS NF font or equivalent

---

Disclaimer: For anyone whom I've pointed here. All of this is stuff that I prefer, it is living, may change, and i highly suggest you figure what you prefer and not use my entire dotfile(s). Learn what each line does then integrate them. Strictly for `vim`ing, spend a long time *not* using plugins and make some snippets yourself. That way you may have an idea on how these plugins work, when you innevitably install them.
