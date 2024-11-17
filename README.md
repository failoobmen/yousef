git config core.filemode false - Вот и подсказка
________________________________________________

<?php
// Подключение файла соединения с БД
include_once 'db.class.php';

// хост БД
define('db_host','127.0.0.1');

// Имя БД
define('db_name','matsievskij');

// Пользователь БД
define('db_user','admin');

// Пароль БД
define('db_pass','admin_password');

// Обявление класса для подключения к бд
$db = new DB_class(db_host,db_name,db_user,db_pass);

$query = $db->select(true,"*","matsievskij");


echo "<ui>";
for ($i = 0; $i < count($query);$i++) {
  echo "<li>Task ID: " . $query[$i]['task_id'] . "<br>";
  echo "Text: " . $query[$i]['task_text'] . "<br>";
  echo "Date: " . $query[$i]['task_date'] . "<br>";
  echo "Complete: " . $query[$i]['task_complete'] . "<br>";
  
}
echo "</ul>";
?>
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
