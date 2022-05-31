<?php 
    //Start Session


    //Create Constants to Store Non Repeating Values
    // define('SITEURL', 'http://localhost/food-order-website-php/');
    define('LOCALHOST', 'localhost');
    define('DB_USERNAME', 'root');
    define('DB_PASSWORD', 'root');
    define('DB_NAME', 'movie_db');
    
    $conn_1 = mysqli_connect(LOCALHOST, DB_USERNAME, DB_PASSWORD); //Database Connection
    $db_select = mysqli_select_db($conn_1, DB_NAME); //SElecting Database


?>