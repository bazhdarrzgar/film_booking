<?php

$connect = mysqli_connect('localhost', 'root', 'root', 'movie_db');

if (!$connect) {
    exit('connection failed for database ...');
}

?>

<?php
// $servername = "localhost";
// $username = "root";
// $password = "root";
// $dbname = "movie_db";

// // Create connection
// $conn = new mysqli($servername, $username, $password, $dbname);

// // Check connection
// if ($conn->connect_error) {
//   die("" . $conn->connect_error);
//   }
?>
