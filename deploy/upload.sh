#!/usr/bin/expect -f
# 第一个参数目标目录，第二个参数项目名
set dir [lindex $argv 0]
set projectname [lindex $argv 1]
set remote_ip [lindex $argv 2]
set reupload [lindex $argv 3]

send_user "step 4.1:更新远程机器start.sh脚本\r\n"
send_user "\r\n"
spawn scp "/Users/yangying/work/source/github/amber-project/startup.sh" root@${remote_ip}:/opt/
expect "*password:"
send "*******\r"
interact
send_user "\r\n"

if {$reupload == true} {
    send_user "step 4.2:上传应用执行文件\r\n"
    send_user "\r\n"
    spawn scp "$dir/$projectname.jar" root@${remote_ip}:/opt/
    expect "*password:"
    send "*************\r"
    interact
}

send_user "step 5:restart remote services"
spawn ssh root@${remote_ip}
expect "*password:"
send "*************\r"
expect "*Last login:"
send "cd /opt\r"
send "/opt/startup.sh $projectname\r"
expect "restarting"
#send "echo $?"
#expect "0"
expect eof
