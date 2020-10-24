#timesyne.sh
#expect的安装路径
#/usr/local/bin/expect这个路径安装完expect之后 which expect可以查看
#!/usr/local/bin/expect

set timeout 10
set passwd [lindex $argv 0]

spawn sudo sntp -sS ntp.aliyun.com
#根据输出传递数据,在这里是等待密码提示显示
expect "*assword*"
send "$passwd\n"
#interact
expect eof
exit
