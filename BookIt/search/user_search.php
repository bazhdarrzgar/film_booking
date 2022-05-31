<?php

include('connection.php');

// $keyword = $_GET['keyword'];

$query = mysqli_query($connect, "SELECT * FROM user");
$results = mysqli_fetch_all($query, MYSQLI_ASSOC);

?>
<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>



<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
* {box-sizing: border-box;}

body {
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
}

.topnav {
  overflow: hidden;
  background-color: #e9e9e9;
}

.topnav a {
  float: left;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav a:hover {
  background-color: #ddd;
  color: black;
}

.topnav a.active {
  background-color: #2196F3;
  color: white;
}

.topnav .search-container {
  float: right;
}

.topnav input[type=text] {
  padding: 6px;
  margin-top: 8px;
  font-size: 17px;
  border: none;
}

.topnav .search-container button {
  float: right;
  padding: 6px 10px;
  margin-top: 8px;
  margin-right: 16px;
  background: #ddd;
  font-size: 17px;
  border: none;
  cursor: pointer;
}

.topnav .search-container button:hover {
  background: #ccc;
}

@media screen and (max-width: 600px) {
  .topnav .search-container {
    float: none;
  }
  .topnav a, .topnav input[type=text], .topnav .search-container button {
    float: none;
    display: block;
    text-align: left;
    width: 100%;
    margin: 0;
    padding: 14px;
  }
  .topnav input[type=text] {
    border: 1px solid #ccc;  
  }
}

</style>
<link rel="stylesheet" href="/SportsVerse-main\SportsVerse-main\Update\update-style.css"> 
</head>
<body>

<div class="topnav">

  <a class="active" href="../../index.html">Home</a>
  <a href="../movie_desc.php">Movie</a>
  <a href="../logout.php">LogOut</a>
  <a href="../AdminPage.php">Admin</a>
  <div class="search-container">
    <form action="search.php" method="get">
      <input type="text" placeholder="keyword.." name="keyword" value="<?= isset($_GET['keyword']) ? $_GET['keyword'] : '' ?>">
      <button type="submit"><i class="fa fa-search"></i> Search</button>

    </form>
  </div>
</div>
<br>


<body>


<center>

<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
    <br><br>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Username</th>
            <th>Phone</th>
            <th>Email</th>
        </tr>
        <?php foreach ($results as $result) : ?>
            <tr>
                <td><?= $result['user_id']; ?></td>
                <td><?= $result['fullname']; ?></td>
                <td><?= $result['username']; ?></td>
                <td><?= $result['phone']; ?></td>
                <td><?= $result['email']; ?></td>
              
            </tr>
        <?php endforeach; ?>
    </table></center>
</body>

</html>
