<?php
include 'database.php'; 

$email = isset($_POST['email']) ? $_POST['email'] : '';
$number = isset($_POST['number']) ? $_POST['number'] : '';
$name = isset($_POST['name']) ? $_POST['name'] : '';
$password = isset($_POST['password']) ? $_POST['password'] : '';

$category = "customer";
$access = 1;
$role = "undefined";
$country = "undefined";
$Address_1 = "undefined";
$Address_2 = "undefined";
$town = "undefined";
$state = "undefined";


if (empty($email) || empty($number)) {
    echo json_encode(["error" => "Missing email or number"]);
    exit;
}

//Check if user exists
$sql = "SELECT * FROM fresh_fare_signup WHERE email = '$email' AND mob_num = '$number'";
$result = mysqli_query($conn, $sql);
$count = mysqli_num_rows($result);

if ($count >= 1) {
    echo json_encode(["status" => "Error"]);
} else {
    $insert = "INSERT INTO fresh_fare_signup (username, email, mob_num, password, category, access, role, country, Address_1, Address_2, town, state)
     VALUES ('$name', '$email', '$number', '$password', '$category', '$access', '$role', '$country', '$Address_1', '$Address_2', '$town', '$state')";
    if (mysqli_query($conn, $insert)) {
        $last_id = mysqli_insert_id($conn); 
        echo json_encode([
            "status" => "Success",
            "signup_id" => $last_id
        ]);
    } else {
        echo json_encode("Database error: " . mysqli_error($conn));
    }
}
?>
