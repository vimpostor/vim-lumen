FROM archlinux:base

RUN pacman -Syu --noconfirm gvim neovim make diffutils
COPY . /tmp/vim-lumen
WORKDIR /tmp/vim-lumen/tests
CMD make
