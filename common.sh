code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -f ${log_file}

print_head() {
  echo -e "\e[35m$1\e[0m"
}

status_check() {
  if [ $1 -eq 0 ]; then
    echo SUCCESS
  else
    echo FAIL
    echo "Read the log file ${log_file} for more information about the error"
    exit 1
  fi
}
schema_setup()
{
#if [ "${schema_type} == "mongo" ]; then
  print_head "Copy mongodb repository"
  cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
  status_check $?

  print_head "install mongo client"
  yum install mongodb-org-shell -y &>>${log_file}
  status_check $?

  print_head "load schema "
  mongo --host mongodb.devopsb71.cloud </app/schema/${component}.js &>>${log_file}
  status_check $?
}
nodejs(){

  print_head "Configure nodejs repository"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
  status_check $?

  print_head "install nodejs"
  yum install nodejs -y &>>${log_file}
  status_check $?

  print_head "create user roboshop user"
  id roboshop &>>${log_file}
  if [ $? -ne 0 ]; then
   useradd roboshop &>>${log_file}
  fi
  status_check $?

  print_head "Create application directory"
  if [ ! -d /app ]; then
    mkdir /app &>>${log_file}
  fi
  status_check $?


  print_head "Delete old content"
  rm -rf /app/* &>>${log_file}
  status_check $?


  print_head "downloading app content"
  curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
  status_check $?

  cd /app

  print_head "extracting app content"
  unzip /tmp/${component}.zip &>>${log_file}
  status_check $?

  print_head "installing nodejs dependent"

  npm install &>>${log_file}
  status_check $?

  print_head "Copying systemd file "
  cp ${code_dir}/configs/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
  status_check $?

  print_head "reload system"
  systemctl daemon-reload &>>${log_file}
  status_check $?

  print_head "enable ${component} service"
  systemctl enable ${component} &>>${log_file}
  status_check $?

  print_head "restart ${component}  service"
  systemctl start ${component} &>>${log_file}
  status_check $?


schema_setup

}
