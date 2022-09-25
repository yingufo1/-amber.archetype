#!/bin/bash
##
##注释，包括脚本功能说明、作者、日期、参数说明
## -rip 目标IP，不传入则使用默认的
# 第一个参数是项目名，第二个和第三个参数是启动端口，可以默认没有
##
process=`pgrep java`
default_port=(8081 8082)
file="$1.jar"
logDir=/opt/logs

port_1=${default_port[0]}
port_2=${default_port[1]}

if [ ! -z $2 ];then
    port_1=$2
fi

if [ ! -z $3 ];then
    port_2=$3
fi

echo "待启动的端口:$port_1,$port_2"

if [ $port_1 == $port_2 ];then
    echo "启动的端口不能相同:$port_1,$port_2"
    exit 1
fi

if [ ${#process} == 0 ]; then
    echo "not running"
    for (( i=0;i<2;i=i+1 ))
        do
            if [ $i == 0 ];then
                echo "starting server 1"
                nohup java -jar -Dserver.port=$port_1 -Dlog.root.dir=$logDir $file &
            else
                echo "starting server 2"
                nohup java -jar -Dserver.port=$port_2 -Dlog.root.dir=$logDir $file &
            fi
        done
else
    declare -i i=0
    for pid in $process
        do
            echo "running ,kill it:$pid"
            kill -9 $pid
            if [ $i == 0 ];then
                echo "restarting server 1"
                nohup java -jar -Dserver.port=$port_1 -Dlog.root.dir=$logDir $file &
            else
                echo "restarting server 2"
                nohup java -jar -Dserver.port=$port_2 -Dlog.root.dir=$logDir $file &
            fi
            i+=1
    done
fi


sleep 2
process=`pgrep java`
echo "new pid:$process"
#tail -f /Users/yangying/work/logs/alidata1/admin/appName_IS_UNDEFINED/logs/VM-8-14-centos_app_appName_IS_UNDEFINED_lt_info.log
