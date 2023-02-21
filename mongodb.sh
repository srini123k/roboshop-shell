source common.sh

print_head "Setup MongoDB repository"

cp configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

print_head "Install Mongodb service"
yum install mongodb-org -y &>>${log_file}

print_head "Update mongodb listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

print_head "Enable Mongodb"
systemctl enable mongod

print_head "Start Mongodb"
systemctl start mongod

#Update config file vim /etc/mongod.conf from 127.0.0.1 with 0.0.0.0

print_head "restart MongoDB"
systemctl restart mongod