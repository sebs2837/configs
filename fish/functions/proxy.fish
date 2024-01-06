#!/bin/fish


function launch_squid
    if type -p /opt/homebrew/sbin/squid 
        /opt/homebrew/opt/squid/sbin/squid -N -d 1 -f ~/.config/squid.conf -
    else
        echo "Failed to launch squid"
        return 1
    end
end

function proxy_vpn_squid -d "Configure http(s) proxy for VW environment with squid"
      set -xg http_proxy $argv[1]
      set -xg https_proxy $argv[1]
      set -xg all_proxy $argv[1] 
      set -xg no_proxy $argv[2]

      if not pgrep -f squid > /dev/null
        launch_squid
      end
end

function proxy_vpn -d "Configure http(s) proxy for VW environment"
      set -xg http_proxy $argv[1]
      set -xg https_proxy $argv[1]
      set -xg all_proxy $argv[1]
      set -xg no_proxy $argv[2]
end


function proxy -d "change proxy settings according to param"
    argparse h/help v/vpn s/squid c/cicd -- $argv 
    or return 0

    if test -f $fish_function_path[1]/proxy_cfg.fish
        source $fish_function_path[1]/proxy_cfg.fish
    else 
        echo "Failed to find proxy_cfg"
    end


    if set -ql _flag_vpn
        proxy_vpn $VPN_PROXY $CORP_PROXY_SETTINGS
        return 0
    else if set -ql _flag_help
        echo "proxy [-h|--help] [-c|--cicd] [-s|--squid] [-v|--vpn]"
        return 0
    else if set -ql _flag_squid
        proxy_vpn_squid $SQUID_PROXY $CORP_PROXY_SETTINGS
        return 0
    else if set -ql _flag_cicd
        proxy_ci_cd $CICD_CLIENT $CICD_PROXY
        return 0
    else
        proxy_none
        return 0
    end
end

function proxy_none -d "Remove http(s) proxy settings"
      set -xg http_proxy 
      set -xg https_proxy 
      set -xg all_proxy 
      set -xg no_proxy localhost
end

function proxy_ci_cd -d "Configure http(s) proxy for ext git.hub usage"
    if not pgrep -f $argv[1] > /dev/null
        $argv[1] 
    end
    set -xg http_proxy $argv[2]
    set -xg https_proxy $argv[2]
end
