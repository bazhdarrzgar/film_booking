
<?php
include "db/dbcon.php";

// $var1 = "1";
// $var2 = "1";
// if ($var1 = $var2) {
//   $world=mysqli_query($conn,"SELECT count(user_id) from seats ;");
//   $magic_session = mysqli_fetch_assoc($world);
//   $temp_seat_id = $magic_session;
//   print $temp_seat_id;

//   // $conn->close();
// } else {
//   echo "this is not work";
// }

$sql = "SELECT count(seat_id) from seats ";
$result = mysqli_query($conn, $sql);



while ($row = mysqli_fetch_assoc($result)) {
    $echo = "hi";
}
?>