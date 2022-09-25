#!/bin/bash
##
##注释，包括脚本功能说明、作者、日期、参数说明
## -rip 目标IP，不传入则使用默认的
# 第一个参数是应用名
##

function help(){
cat <<EOF
Usage ./start.sh [options] [args...]

options
    -h print help info
    -r <remote ip> default:$default_remote_ip
    -p <project name> default:$default_projectname
    -b <true|false>  default:${default_rebuild}
                rebuild package flag
    -u <true|false> default:$default_reupload
                reupload jar flag
EOF
}

# 默认参数定义
default_remote_ip=82.157.252.130
default_projectname=amber.account
default_rebuild=false
default_reupload=false

# 执行变量赋值
rebuild=$default_rebuild #是否重新构建部署包
reupload=$default_reupload #是否重新上传可执行文件
projectname=$default_projectname #项目名称
remoteIp=$default_remote_ip


while getopts "hr:p:b:u:" opt;do
    case $opt in
        h)
            help
            exit 0
            ;;
        b)
            if [ $OPTARG != true ] && [ $OPTARG != false ];then
                echo "unexpect argument ,only ture|false" >&2
                exit 1
            fi
            rebuild=$OPTARG
            ;;
        p)
            projectname=$OPTARG
            ;;
        u)
            if [ $OPTARG != true ] && [ $OPTARG != false ];then
                echo "unexpect argument ,only ture|false" >&2
                exit 1
            fi
            reupload=$OPTARG
            ;;
        r)
          remoteIp=$OPTARG
          ;;
        \?)
            echo "unexpect option:-$OPTARG" >&2
            exit 1
            ;;
    esac
done

project_home="$(pwd)/${projectname}"
echo "exec env,rebuild:$rebuild,reupload:$reupload,project:$projectname,remote:$default_remote_ip,pojectHome:$project_home"



echo "step1:cd ${project_home}"
echo ""
cd ${project_home} || exit
if [ $? -ne 0 ]; then
    exit 0
fi



# 执行maven命令，重新打包应用
if [ $rebuild == true ];then
    echo "step2:build package ${project_home}"
    echo ""
    mvn clean package -Dmaven.test.skip=true
fi

if [ $? -ne 0 ]; then
    exit 1
fi

echo "step3:copy target file:${project_home}/target/${projectname}.jar to remote"
echo ""

#与远程服务交互：1、上传目标文件到部署机器ID；2、重启远程服务
result=expect /Users/yangying/work/source/github/amber-project/upload.sh ${project_home}/target ${projectname} ${remoteIp} ${reupload}
echo "${result}"

exit
