#source common.sh

#print_head "Installing nginx"
#yum install python36 gcc python3-devel -y

#print_head "Installing nginx"
#useradd roboshop

#print_head "Installing nginx"
#mkdir /app

#print_head "Installing nginx"
#curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
#cd /app

#print_head "Installing nginx"
#unzip /tmp/payment.zip

#print_head "Installing nginx"
#pip3.6 install -r requirements.txt

#print_head "Installing nginx"
#systemctl enable payment

#print_head "Installing nginx"
#systemctl start payment


source common.sh

roboshop_app_password=$1
if [ -z "${roboshop_app_password}" ]; then
  echo -e "\e[31mMissing RabbitMQ App User Password argument\e[0m"
  exit 1
fi

component=payment
python
