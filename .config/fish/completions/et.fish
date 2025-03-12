function __fish_et_hosts
    set -l config_hosts (sed -n 's/^Host //p' ~/.ssh/config 2>/dev/null | grep -v '\*')
    set -l known_hosts (sed -n 's/^[^ ]*[ ,]//p' ~/.ssh/known_hosts 2>/dev/null | cut -d ' ' -f 1 | tr ',' '\n')
    echo $config_hosts $known_hosts | sort -u
end

complete -c et -f -a '(__fish_et_hosts)'
