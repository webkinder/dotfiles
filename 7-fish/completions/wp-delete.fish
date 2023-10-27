for site in (find ~/repos/valet -mindepth 1 -maxdepth 1 -type d)
    complete -f -c wp-delete -a "(basename \"$site\")"
end
