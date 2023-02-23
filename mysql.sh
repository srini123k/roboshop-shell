source common.sh

mysql_root_password =$1
if [ -z "${mysql_root_password}"];then
  echo -e "\e[31mMissing mysql root password argument\e[0m"
  exit 1
fi

print_head "Disabling Mmysql 8 version "
dnf module disable mysql -y &>>${log_file}
status_check $?

print_head "Copy mysql repo file"
cp ${code_dir}/configs/mysql.conf /etc/nginx/default.d/mysql.conf &>>${log_file}
status_check $?


print_head "Installing mysql server"
yum install mysql-community-server -y &>>${log_file}
status_check $?

print_head "enable mysql service"
systemctl enable mysqld &>>${log_file}
status_check $?

print_head "start mysql service"
systemctl start mysqld &>>${log_file}
status_check $?

print_head "Set Root password"
echo show databases | mysql -uroot -p${mysql_root_password} &>>${log_file}
if [ $? -ne 0 ]; then
 mysql_secure_installation --set-root-pass ${mysql_root_password} &>>${log_file}
fi

status_check $?


