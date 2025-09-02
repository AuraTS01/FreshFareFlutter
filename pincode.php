<?php

include 'database.php';

$pincode = $_POST['pincode'];

$valid_pincodes = ["641301", "641305","641104"]; 

if (in_array($pincode, $valid_pincodes)) {
    echo json_encode(["status" => "success", "message" => "Delivery available in your area.($pincode)"]);
} else {
    echo json_encode(["status" => "error", "message" => "Invalid Pincode. Delivery is available only in Mettupalayam and Karamadai."]);
}
?>
