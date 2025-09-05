#!/bin/bash

### -> https://github.com/neovim/neovim/blob/master/INSTALL.md

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage

chmod u+x nvim-linux-x86_64.appimage

sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

sudo ln -s /usr/local/bin/nvim /usr/local/bin/v
