<?php
include 'database.php';

$email    = isset($_POST['email']) ? $_POST['email'] : '';
$country  = isset($_POST['country']) ? $_POST['country'] : '';
$Address_1 = isset($_POST['Address_1']) ? $_POST['Address_1'] : '';
$town     = isset($_POST['town']) ? $_POST['town'] : '';
$state    = isset($_POST['state']) ? $_POST['state'] : '';

if (empty($email)) {
    echo json_encode(["status" => "Error", "message" => "Email is required"]);
    exit;
}

$update = "UPDATE fresh_fare_signup 
           SET country='$country', 
               Address_1='$Address_1',            
               town='$town',
               state='$state'        
           WHERE email='$email'";

if (mysqli_query($conn, $update)) {
    if (mysqli_affected_rows($conn) > 0) {
        echo json_encode(["status" => "Success", "message" => "Billing details updated"]);
    } else {
        echo json_encode(["status" => "Error", "message" => "No record found with this email"]);
    }
} else {
    echo json_encode(["status" => "Error", "message" => mysqli_error($conn)]);
}
?>
