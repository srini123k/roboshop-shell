source common.sh

print_head "Installing nginx"
yum install nginx -y &>>${log_file}

print_head "removing old content "
rm -rf /usr/share/nginx/html/* &>>${log_file}

print_head "Downloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}

print_head "Extracing downloaded frontend"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>${log_file}

print_head "Copying Nginx config for Roboshop"
cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

print_head "Enable nginx "
systemctl enable nginx &>>${log_file}

print_head "Starting nginx"
systemctl restart nginx &>>${log_file}

