<?php
include 'database.php';

$email = isset($_POST['email']) ? $_POST['email'] : '';

if (empty($email)) {
    echo json_encode(["status" => "Error", "message" => "Email is required"]);
    exit;
}

$sql = "SELECT username, email, mob_num FROM fresh_fare_signup WHERE email = '$email' LIMIT 1";
$result = mysqli_query($conn, $sql);

if ($result && mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);
    echo json_encode([
        "status" => "Success",
        "name" => $row['username'],
        "email" => $row['email'],
        "number" => $row['mob_num']
    ]);
} else {
    echo json_encode(["status" => "Error", "message" => "User not found"]);
}
?>
