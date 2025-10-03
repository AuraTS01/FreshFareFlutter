<?php
include 'database.php'; 

$email    = $_POST['email']    ?? '';
$number   = $_POST['number']   ?? '';
$name     = $_POST['name']     ?? '';
$password = $_POST['password'] ?? '';

$category  = "customer";
$access    = 1;
$role      = "undefined";
$country   = "undefined";
$Address_1 = "undefined";
$Address_2 = "undefined";
$town      = "undefined";
$state     = "undefined";

if (empty($email) || empty($number)) {
    echo json_encode(["error" => "Missing email or number"]);
    exit;
}

$sql = "SELECT id FROM fresh_fare_signup WHERE email = '$email' AND mob_num = '$number'";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) >= 1) {
    $row = mysqli_fetch_assoc($result);
    echo json_encode([
        "status"    => "Exists",
        "signup_id" => $row['id']
    ]);
} else {
    $insert = "INSERT INTO fresh_fare_signup 
        (username, email, mob_num, password, category, access, role, country, Address_1, Address_2, town, state)
        VALUES ('$name', '$email', '$number', '$password', '$category', '$access', '$role', '$country', '$Address_1', '$Address_2', '$town', '$state')";
    
    if (mysqli_query($conn, $insert)) {
        $last_id = mysqli_insert_id($conn); 
        echo json_encode([
            "status"    => "Success",
            "signup_id" => $last_id,
        ]);
    } else {
        echo json_encode(["status" => "Error", "message" => mysqli_error($conn)]);
    }
}

?>
