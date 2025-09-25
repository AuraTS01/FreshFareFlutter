<?php
include 'database.php'; 

$email = isset($_POST['email']) ? $_POST['email'] : '';
$password = isset($_POST['password']) ? $_POST['password'] : '';



//Check if user exists
$sql = "SELECT * FROM fresh_fare_signup WHERE email = '$email' AND password = '$password'";
$result = mysqli_query($conn, $sql);
$count = mysqli_num_rows($result);

if ($count >= 1) {
    $row = mysqli_fetch_assoc($result);
    $last_id = mysqli_insert_id($conn); 
    echo json_encode([
        "status" => "Success",
        "username" => $row['username'],
        "email" => $row['email'],
        "number" => $row['mob_num'],
        "category"  => $row['category'],
        "signup_id" => $last_id]);
} else {
     echo json_encode(["status" => "Error"]);
    
}

?>