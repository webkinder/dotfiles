function mvf-create --description "Create movefile.yml in the current directory based on a template and user input"
    set -l movefile "movefile.yml"
    set -l movefile_path "$PWD/$movefile"
    set -l movefile_template "movefile.yml.template"
    set -l movefile_template_path "$HOME/.dotfiles/templates/$movefile_template"

    if not test -f $movefile_template_path
        echo "Template file not found: $movefile_template_path"
        return 1
    end

    if test -f $movefile_path
        echo "$movefile already exists."
        return 1
    end

    cp $movefile_template_path $movefile_path
    or return 1

    echo "Enter the following information:"
    set -l replacements (begin
        read -p "Production vhost: " prod_vhost
        read -p "Production wordpress_path: " prod_wordpress_path
        read -p "Production database name: " prod_database_name
        read -p "Production database user: " prod_database_user
        read -p "Production SSH host: " prod_ssh_host

        echo "prod.vhost=$prod_vhost"
        echo "prod.wordpress_path=$prod_wordpress_path"
        echo "prod.database.name=$prod_database_name"
        echo "prod.database.user=$prod_database_user"
        echo "prod.ssh.host=$prod_ssh_host"
        echo "local.vhost=https://(basename $PWD).test"
        echo "local.wordpress_path=$PWD"
        echo "local.database.name=(basename $PWD)"
        echo "local.database.user=$USER"
    end)

    for replacement in $replacements
        set -l key (echo $replacement | cut -d= -f1)
        set -l value (echo $replacement | cut -d= -f2-)
        sed -i '' "s/$key/$value/g" $movefile_path
        or return 1
    end

    echo "Created $movefile."
end
