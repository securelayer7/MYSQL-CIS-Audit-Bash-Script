#!/bin/bash
#SecureLayer7 MYSQL Audit Script
#Developed and Modified By Sandeep Kamble for the official purpose only
#This configuration review script is deveoped according specific needs.
#Last Update Data : 7 July, 2016
# Use following command to run this scipt 
# chmod +x mysqlAudit.sh
# ./mysql.sh

echo "Enter your username for mysql (root recommended)";
read username;
echo "Enter password (password not shown)";
unset password;
while IFS= read -r -s -n1 pass; do
  if [[ -z $pass ]]; then
     echo
     break
  else
     echo -n '*'
     password+=$pass
  fi
done
echo "CREATING DIRECTORIES : RESULTS"
mkdir -p results

### General Inforamtion for MYSQL Audit 

echo "Time and Date" >> results/System_info.txt
echo 'select NOW()'| mysql -u$username -p$password >> results/System_info.txt

echo "MYSQL VERSION" >> results/System_info.txt
echo 'show variables like "%version%"'| mysql -u$username -p$password >> results/System_info.txt

echo "USERS" >> results/Users.txt
echo 'select user,host from mysql.user'| mysql -u$username -p$password >> results/Users.txt

echo "CURRENT USERS" >> results/Users.txt
echo 'show processlist'| mysql -u$username -p$password >> results/Users.txt

echo "ALL VARIABLES" >> results/All_variables.txt
echo 'show variables'| mysql -u$username -p$password >> results/All_variables.txt

echo "DATABASES" >> results/Databases.txt
echo 'show databases'| mysql -u$username -p$password >> results/Databases.txt 
echo 'show databases'| mysql -u$username -p$password |grep -v Database>> results/mysql_databases

echo "ALL TABLES FROM ALL DATABASES" >> results/Tables_from_databases.txt
echo 'select table_schema, table_name from information_schema.tables'| mysql -u$username -p$password >> results/Tables_from_databases.txt
echo 'select table_schema, table_name from information_schema.tables'| mysql -u$username -p$password >> results/mysql_tables

echo "TABLES FROM ALL DATABASES EXCEPT INTERNAL" >> results/Not_system_tables.txt 
echo "SELECT table_schema, table_name FROM information_schema.tables WHERE table_schema NOT IN ( 'information_schema', 'performance_schema', 'mysql' )"| mysql -u$username -p$password >> results/Not_system_tables.txt


#Operating System Level Configuration 
echo "Starting of MYSQL Audit" > results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 1.6" >> results/MYSQLAudit.txt
echo "show variables like 'datadir'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 2.2" >> results/MYSQLAudit.txt
echo "show variables like 'basedir'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Logging" >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 3.1" >> results/MYSQLAudit.txt
echo "show variables like 'log_error'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 3.3 & 3.4 " >> results/MYSQLAudit.txt
echo "show variables like 'log_bin'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "show variables like 'log_bin'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 4.5" >> results/MYSQLAudit.txt
echo "select user from mysql.user where user = 'root'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 4.9" >> results/MYSQLAudit.txt
echo "select user from mysql.user where host = '%'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 4.10" >> results/MYSQLAudit.txt
echo "select user, password from mysql.user where length(password) = 0 or password is null" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 4.11" >> results/MYSQLAudit.txt
echo "select user from mysql.user where user = ''" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "MySQL Permissions" >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 5.1" >> results/MYSQLAudit.txt
echo "select user, host from mysql.user where (Select_priv = 'Y') or (Insert_priv = 'Y') or (Update_priv = 'Y') or (Delete_priv = 'Y') or (Create_priv = 'Y') or (Drop_priv = 'Y')" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "select user, host from mysql.db where db = 'mysql' and ((Select_priv = 'Y') or  (Insert_priv = 'Y') or (Update_priv = 'Y') or (Delete_priv = 'Y') or (Create_priv = 'Y') or (Drop_priv = 'Y'))" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 5.2" >> results/MYSQLAudit.txt
echo "select user, host from mysql.user where File_priv = 'Y'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 5.3 " >> results/MYSQLAudit.txt
echo "select user, host from mysql.user where Process_priv = 'Y'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 5.4 " >> results/MYSQLAudit.txt
echo "select user, host from mysql.user where Super_priv = 'Y'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 5.5 " >> results/MYSQLAudit.txt
echo "select user, host from mysql.user where Shutdown_priv ='Y'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 5.6 " >> results/MYSQLAudit.txt
echo "select user, host from mysql.user where Create_user_priv = 'Y'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "MySQL Configuration" >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 6.2" >> results/MYSQLAudit.txt
echo "show variables like 'local_infile'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 6.3 " >> results/MYSQLAudit.txt
echo "show variables like 'old_passwords'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 6.4 " >> results/MYSQLAudit.txt
echo "show variables like 'safe_show_database'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 6.5 " >> results/MYSQLAudit.txt
echo "show variables like 'secure_auth'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 6.6 " >> results/MYSQLAudit.txt
echo "show variables like 'skip_grant_table'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 6.7 " >> results/MYSQLAudit.txt
echo "show variables like 'have_merge_engin'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 6.8 " >> results/MYSQLAudit.txt
echo "show variables like 'skip_networking'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 6.10 " >> results/MYSQLAudit.txt
echo "show variables like 'have_symlink'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo " SSL Configuration" >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 7.2" >> results/MYSQLAudit.txt
echo "show variables like 'have_openssl'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "show variables like 'ssl_key'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "show variables like 'ssl_ca'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "################################" >> results/MYSQLAudit.txt
echo " " >> results/MYSQLAudit.txt
echo "Auditing Guidance for section 7.2" >> results/MYSQLAudit.txt
echo "show variables like 'have_openssl'" | mysql -u$username -p$password >> results/MYSQLAudit.txt
echo "##################END AUDIT##############" >> results/MYSQLAudit.txt
