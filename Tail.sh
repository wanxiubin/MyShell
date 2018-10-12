#!/bin/bash

downfile=""
servername=""
param1=$1
Path="/root/tera-server-local/bin/"

ShowUsage()
{
    echo -e "$0:\n  DESCRIPTION:\n\t\
-g\tShow GameServer log\n\t\
-ga\tShow GatewayServer log\n\t\
-w\tShow WorldServer log\n\t\
-d\tShow DatabaseServer log\n\t\
-e\tShow Err\n\t\
-a\tShow All"

}

ShowLog()
{
    #parse file
    downfile=`find "$Path" -name "*log*" | grep "Logs" | grep -v '\\\\' | grep "$servername"`

    #show log with color
    tail -f  $downfile |  perl -pne 's/(.*INFO.*)/\e[1;36m$1\e[0m/g; s/(.*DEBUG.*)/\e[1;32m$1\e[0m/g; s/(.*WARN.*)/\e[1;33m$1\e[0m/g; s/(.*ERR.*)/\e[1;31m$1\e[0m/g'
}

ShowErr()
{
    #parse file
    downfile=`find "$Path" -name "*log*" | grep "Logs"|  grep -v '\\\\'`

	#show log with color
	cat $downfile | grep  " exception \| at\|^System" |  perl -pne 's/(.*2017.*)/\e[1;31m$1\e[0m/g; '
    echo -e "\033[1;32m现在游戏服的时间:`date`\033[0m"

    #down log
    cat $downfile | grep  " exception \| at\|^System" > server_err.log
    echo -e "现在游戏服的时间:`date`" >> server_err.log
    sz server_err.log
    rm server_err.log
}

test()
{
    cd .
    clear
    case $param1 in
    -g)
    servername="GameServer"
    ShowLog
    ;;
    -ga)
    servername="GatewayServer"
    ShowLog
    ;;
    -w)
    servername="WorldServer"
    ShowLog
    ;;
    -d)
    servername="DatabaseServer"
    ShowLog
    ;;
    -a)
    ShowLog
    ;;
    -e)
    ShowErr
    ;;
    *)
    ShowUsage
    ;;
    esac
}

test
