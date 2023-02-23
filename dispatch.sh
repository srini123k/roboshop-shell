#source common.sh


#yum install golang -y

#useradd roboshop


#mkdir /app

#curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
#cd /app
#unzip /tmp/dispatch.zip

#cd /app
#go mod init dispatch
#go get
#go build

#systemctl daemon-reload

#systemctl enable dispatch
#systemctl start dispatch



source common.sh

#roboshop_app_password=$1
#if [ -z "${roboshop_app_password}" ]; then
 # echo -e "\e[31mMissing RabbitMQ App User Password argument\e[0m"
 # exit 1
#fi

component=dispatch
golang

