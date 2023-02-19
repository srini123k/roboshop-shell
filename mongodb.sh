cp config.mongodb.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
systemctl enable mongod
systemctl start mongod

#Update config file vim /etc/mongod.conf from 127.0.0.1 with 0.0.0.0

systemctl restart mongod