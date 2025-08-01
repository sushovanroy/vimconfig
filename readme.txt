// command for copy .vimrc file 
cp .vimrc $HOME
// command for copy .vim directory
cp -r .vim  $HOME
//After copy build the cscope and ctag file (in the project directory) using script 
build_cscope.sh
//To see what config files Vim is using, run:
// vim --version  
// in the output look for following lines
//system vimrc file: "/etc/vim/vimrc"
// user vimrc file: "$HOME/.vimrc"
