# macOS Dotfiles Setup

1. Run the script by typing `./install` in your terminal.
2. Add phpmyadmin to laravel valet by executing the following command: `cd $(brew --prefix phpmyadmin)/share/phpmyadmin && valet link && valet secure phpmyadmin && cd`
3. Allow no-password logins for phpmyadmin by running `vim $(brew --prefix phpmyadmin)/share/phpmyadmin/config.inc.php` in your Terminal and setting `$cfg['Servers'][$i]['AllowNoPassword']` to `true`.
