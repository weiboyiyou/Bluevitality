#!/bin/bash

#数据库账号
DB_USERNAME="root"
#数据库密码
DB_PASSWORD="paybay123"
#数据库主机IP地址
DB_host="localhost"
#备份的数据库名
DB_NAME="mysql"
#本地保存的路径
BACK_UP_PATH="/var/tmp"
#远端存放备份的主机IP(默认ROOT账户)
REMOTE_IP="1.1.1.1"
#远端存放备份的路径
REMOTE_DIR="/var/tmp"


function backup() {
	time=$(date "+%F_%H:%M")
	mysqldump -u${DB_USERNAME} -p{DB_PASSWORD} -h {DB_host} --single-transaction ${DB_NAME} > ${BACK_UP_PATH:=/root}/${DB_NAME}.sql.${time} &> /dev/null	
	rsync -avz -e ssh ${BACK_UP_PATH}/${DB_NAME}.sql.${time} root@${REMOTE_IP}:/var/tmp
}

backup


[[ "$?" != "0" ]] && echo "备份失败,时间：${time}"  >> /var/log/db_backup.log


#注意！-------------------------------------------------------------------
#公私钥认证：
#执行下面命令并一路回车即可：
ssh-keygen -t rsa 
#将生成的公钥存入需要链接的服务器：(执行以上操作时，将会提示输入远程主机帐户和密码，然后就会自动将公匙拷贝至远程目录)
ssh-copy-id -i ~/.ssh/id_rsa.pub 192.168.1.1
#现在可不需要密码就可以ssh连接到远程主机。参考：http://blog.csdn.net/yahohi/article/details/15501599

#注意！-------------------------------------------------------------------
#需要将本脚本给予x权限：chmod a+x 脚本名字
#然后再将本脚本的绝对路径存入crontab中，（例：每日备份），先使用命令进入计划的编辑模式：crontab -e
#加入下面的一行后wq保存离开....

01 03 * * * /root/本脚本名字.sh