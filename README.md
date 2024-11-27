git config core.filemode false - Вот и подсказка
________________________________________________
error on notebook fix:

cd "C:\Program Files\Docker\Docker"
./DockerCli.exe -SwitchDaemon
______________________________________________________
wsl —unregister docker-desktop-data (docker engine not starting)

__________________
ERROR 500 fix:
win+r
powershell
net stop WAS (служба активации виндовс мешает и выдает ошибку 500 (порт 80))
net stop W3SVC 
_____________________
PhpMyAdmin при правильном вводе пароля не логинится:
mysqld start
_______________________
Конфиг:  
$dbuser='admin';
$dbpass='admin_password';
$basepath='';
$dbname='phpmyadmin';
$dbserver='127.0.0.1';
$dbport='3306';
$dbtype='mysql';
___________________________
