# SecureLayer7 MYSQL Audit Script
# Developed and Modified By Sandeep Kamble for the official purpose only
# This configuration review script is developed according to specific needs.
# Last Update Data: 7 July, 2016
# Use following command to run this script
# Set-ExecutionPolicy Unrestricted
# ./MYSQL-CIS-Audit.ps1

Write-Host "Enter your username for mysql (root recommended)"
$username = Read-Host

Write-Host "Enter database ip adress :"
$ipaddr = Read-Host

Write-Host "Enter database port :"
$port = Read-Host

Write-Host "Enter password (password not shown)"
$password = Read-Host -AsSecureString
$passwordText = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

# CREATING DIRECTORIES: RESULTS
Write-Host "CREATING DIRECTORIES : RESULTS"
New-Item -ItemType Directory -Path "results" -Force | Out-Null

# General Information for MYSQL Audit
Write-Host "SecureLayer7 MYSQL Audit Started"

# Time and Date
Add-Content -Path "results/System_info.txt" -Value "Time and Date"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select NOW()' | Out-File -Append -FilePath "results/System_info.txt"

# MYSQL VERSION
Add-Content -Path "results/System_info.txt" -Value "MYSQL VERSION"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "%version%"' | Out-File -Append -FilePath "results/System_info.txt"

# USERS
Add-Content -Path "results/Users.txt" -Value "USERS"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user,host from mysql.user' | Out-File -Append -FilePath "results/Users.txt"

# CURRENT USERS
Add-Content -Path "results/Users.txt" -Value "CURRENT USERS"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show processlist' | Out-File -Append -FilePath "results/Users.txt"

# ALL VARIABLES
Add-Content -Path "results/All_variables.txt" -Value "ALL VARIABLES"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables' | Out-File -Append -FilePath "results/All_variables.txt"

# DATABASES
Add-Content -Path "results/Databases.txt" -Value "DATABASES"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show databases' | Out-File -Append -FilePath "results/Databases.txt"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show databases' | Select-String -Pattern "Database" -NotMatch | Out-File -FilePath "results/mysql_databases.txt"

# TLS VERSION
Add-Content -Path "results/Databases.txt" -Value "TLS VERSION"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select @@tls_version' | Out-File -Append -FilePath "results/Databases.txt"

# ALL TABLES FROM ALL DATABASES
Add-Content -Path "results/Tables_from_databases.txt" -Value "ALL TABLES FROM ALL DATABASES"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select table_schema, table_name from information_schema.tables' | Out-File -Append -FilePath "results/Tables_from_databases.txt"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select table_schema, table_name from information_schema.tables' | Out-File -Append -FilePath "results/mysql_tables.txt"

# TABLES FROM ALL DATABASES EXCEPT INTERNAL
Add-Content -Path "results/Not_system_tables.txt" -Value "TABLES FROM ALL DATABASES EXCEPT INTERNAL"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e "SELECT table_schema, table_name FROM information_schema.tables WHERE table_schema NOT IN ('information_schema', 'performance_schema', 'mysql')" | Out-File -Append -FilePath "results/Not_system_tables.txt"

# Operating System Level Configuration
Add-Content -Path "results/MYSQLAudit.txt" -Value "Starting of MYSQL Audit"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 3.1"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables where variable_name = "datadir"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"

# Auditing Guidance for section 3.2
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 3.2"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "log_bin_basename"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"

# Auditing Guidance for section 2.2
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 2.2"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "basedir"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Logging
Add-Content -Path "results/MYSQLAudit.txt" -Value "Logging"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 3.3
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 3.3"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "log_error"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 3.3
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 3.3"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "log_bin"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 3.4
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 3.4"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "slow_query_log"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 3.5
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 3.5"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "relay_log_basename"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 4.9
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 4.9"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'SHOW VARIABLES LIKE "sql_mode"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 7.5
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 7.5"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'SHOW VARIABLES LIKE "default_password_lifetime"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 7.6
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 7.6"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'SHOW VARIABLES LIKE "validate_password%"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 4.5
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 4.5"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user from mysql.user where user = "root"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 4.9
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 4.9"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user from mysql.user where host = "%"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 4.10
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 4.10"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user, password from mysql.user where length(password) = 0 or password is null' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 4.11
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 4.11"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user from mysql.user where user = ""' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# MySQL Permissions
Add-Content -Path "results/MYSQLAudit.txt" -Value "MySQL Permissions"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 5.1
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 5.1"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user, host from mysql.user where (Select_priv = "Y") or (Insert_priv = "Y") or (Update_priv = "Y") or (Delete_priv = "Y") or (Create_priv = "Y") or (Drop_priv = "Y")' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user, host from mysql.db where db = "mysql" and ((Select_priv = "Y") or  (Insert_priv = "Y") or (Update_priv = "Y") or (Delete_priv = "Y") or (Create_priv = "Y") or (Drop_priv = "Y"))' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 5.2
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 5.2"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user, host from mysql.user where File_priv = "Y"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 5.3
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 5.3"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user, host from mysql.user where Process_priv = "Y"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 5.4
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 5.4"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user, host from mysql.user where Super_priv = "Y"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 5.5
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 5.5"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user, host from mysql.user where Shutdown_priv ="Y"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"

# Blank line
Add-Content -Path "results/MYSQLAudit.txt" -Value " "
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 5.6 "
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'select user, host from mysql.user where Create_user_priv = "Y"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# MySQL Configuration
Add-Content -Path "results/MYSQLAudit.txt" -Value "MySQL Configuration"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 6.2
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 6.2"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "local_infile"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 6.3
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 6.3"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "old_passwords"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 6.4
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 6.4"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "safe_show_database"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 6.5
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 6.5"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "secure_auth"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 6.6
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 6.6"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "skip_grant_table"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 6.7
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 6.7"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "have_merge_engin"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 6.8
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 6.8"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "skip_networking"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 6.10
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 6.10"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "have_symlink"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# SSL Configuration
Add-Content -Path "results/MYSQLAudit.txt" -Value "SSL Configuration"
Add-Content -Path "results/MYSQLAudit.txt" -Value "################################"
Add-Content -Path "results/MYSQLAudit.txt" -Value " "

# Auditing Guidance for section 7.2
Add-Content -Path "results/MYSQLAudit.txt" -Value "Auditing Guidance for section 7.2"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "have_openssl"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "ssl_key"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
mysql --host=$ipaddr --port=$port -u $username -p $passwordText -e 'show variables like "ssl_ca"' | Out-File -Append -FilePath "results/MYSQLAudit.txt"
Add-Content -Path "results/MYSQLAudit.txt" -Value "##################END AUDIT##############"
Write-Host "##################END MYSQL AUDIT##############"
Write-Host "ZIP the result folder and email to consultant"
