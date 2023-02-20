source common.sh

print_head "Setup MongoDB repository"

cp configs/mongodb.repo /etc/yum.repos.d/mongo.repo

print_head "Install Mongodb service"
yum install mongodb-org -y

print_head "Enable Mongodb"
systemctl enable mongod

print_head "Start Mongodb"
systemctl start mongod

#Update config file vim /etc/mongod.conf from 127.0.0.1 with 0.0.0.0
print_head "restart MongoDB"
systemctl restart mongod