# macOS Dotfiles Setup

1. Run the following command in your terminal to install the Command Line Tools for Xcode:
```bash
sudo touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress && sudo softwareupdate -i "$(softwareupdate -l | grep -B 1 -E 'Command Line Tools' | awk -F'*' '/^ *\\*/ {print $2}' | sed -e 's/^ *Label: //' -e 's/^ *//' | sort -V | tail -n1)" && sudo rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
```
2. Clone this repository into your Documents folder:
```bash
cd ~/Documents && git clone https://github.com/webkinder/dotfiles.git && cd ./dotfiles
```
3. Run the script by typing `./install` in your terminal.
4. Add phpmyadmin to laravel valet by executing the following command:
```bash
cd $(brew --prefix phpmyadmin)/share/phpmyadmin && valet link && valet secure phpmyadmin && cd
```
5. Set `$cfg['Servers'][$i]['AllowNoPassword']` to `true` in the `config.inc.php` file:
```bash
vim $(brew --prefix phpmyadmin)/share/phpmyadmin/config.inc.php
```
6. Create a SSH key pair. Replace `mail@webkinder.ch` with your email address:
```bash
ssh-keygen -t ed25519 -a 100 -C "mail@webkinder.ch"
```