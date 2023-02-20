source common.sh

print_head "Configure nodejs repository"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "install nodejs"
yum install nodejs -y &>>${log_file}

print_head "create user roboshop user"
useradd roboshop &>>${log_file}

print_head "Create application directory"
mkdir /app &>>${log_file}

print_head "Delete old content"
rm -rf /app/* &>>${log_file}

print_head "downloading app content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}

cd /app

print_head "extracting app content"
unzip /tmp/catalogue.zip &>>${log_file}

print_head "installing nodejs dependent"

npm install &>>${log_file}

print_head "Copying systemd file "
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

print_head "reload system"
systemctl daemon-reload &>>${log_file}

print_head "enable catalogue service"
systemctl enable catalogue &>>${log_file}

print_head "restart catalogue service"
systemctl start catalogue &>>${log_file}

print_head "Copy mongodb repository"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

print_head "install mongo client"
yum install mongodb-org-shell -y &>>${log_file}

print_head "load schema "
mongo --host mongodb.devopsb71.cloud </app/schema/catalogue.js &>>${log_file}

