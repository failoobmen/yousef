<?php
// Подключение файла соединения с БД
include_once 'db.class.php';

// хост БД
define('db_host','localhost');

// Имя БД
define('matsievskij','name');

// Пользователь БД
define('db_user','root');

// Пароль БД
define('db_pass','password');

// Обявление класса для подключения к бд
$db = new DB_class(db_host,db_name,db_user,db_pass);

$query = $db->select(true,"*","matsievskij","task_id='1'");
?>