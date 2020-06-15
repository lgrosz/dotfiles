# This file checks the diffs for easy updating
# cwd should be "dotfiles/"
for dotfile in .*(^-/)
do
    echo `diff -qs $dotfile ~/$dotfile`
done

