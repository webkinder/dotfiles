# macOS Dotfiles Setup

1. Run the following command in your terminal to install the Command Line Tools for Xcode:
```
sudo touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress && sudo softwareupdate -i "$(softwareupdate -l | grep -B 1 -E 'Command Line Tools' | awk -F'*' '/^ *\\*/ {print $2}' | sed -e 's/^ *Label: //' -e 's/^ *//' | sort -V | tail -n1)" && sudo rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
```
2. Clone this repository into your Documents folder:
```
cd ~/Documents && git clone https://github.com/webkinder/dotfiles.git
```
3. Run the script by typing `./install` in your terminal.
4. Add phpmyadmin to laravel valet by executing the following command:
```
cd $(brew --prefix phpmyadmin)/share/phpmyadmin && valet link && valet secure phpmyadmin && cd
```
5. Allow no-password logins for phpmyadmin by running `vim $(brew --prefix phpmyadmin)/share/phpmyadmin/config.inc.php` in your Terminal and setting `$cfg['Servers'][$i]['AllowNoPassword']` to `true`.
