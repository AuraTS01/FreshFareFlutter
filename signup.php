<?php
include 'database.php'; 

$email = isset($_POST['email']) ? $_POST['email'] : '';
$number = isset($_POST['number']) ? $_POST['number'] : '';
$name = isset($_POST['name']) ? $_POST['name'] : '';
$password = isset($_POST['password']) ? $_POST['password'] : '';

if (empty($email) || empty($number)) {
    echo json_encode(["error" => "Missing email or number"]);
    exit;
}

// Check if user exists
$sql = "SELECT * FROM fresh_fare_signup WHERE email = '$email' AND mob_num = '$number'";
$result = mysqli_query($conn, $sql);
$count = mysqli_num_rows($result);

if ($count >= 1) {
    echo json_encode(["status" => "Error"]);
} else {
    $insert = "INSERT INTO fresh_fare_signup (username, email, mob_num, password) VALUES ('$name', '$email', '$number', '$password')";
    if (mysqli_query($conn, $insert)) {
        echo json_encode(["status" => "Success"]);
    } else {
        echo json_encode("Database error: " . mysqli_error($conn));
    }
}
?>
