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

$query = $db->select(true,"*","matsievskij","");

?>
<!DOCTYPE html>
<html>
  <head>
      <title>Мой задачник</title>
      <link rel="stylesheet" type="text/css" href="style.css"
  </head>
  <body>
  <div class="tasks">
      <?php
      for ($i = 0; $i < count($query);$i++){
      ?>
    
  <div class="task-control">
  <input type="checkbox" name="">
  </div>
  <div class="task-text"><?php echo $query[$i]['task_text'] ?></div>
  <div class="task-date">
  <input type="date" name=''>
  </div>
  </div>
          <?php
  }
  ?>
  </div>
  </body>

</html>
