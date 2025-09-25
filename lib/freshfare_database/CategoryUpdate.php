<?php
include 'database.php';


$id       = $_POST['id'] ?? '';
$category = $_POST['category'] ?? '';
$source   = $_POST['source'] ?? ''; 

if (!empty($id) && !empty($category)) {

    if ($source === "signup") {
        $query = "UPDATE fresh_fare_signup SET category='$category' WHERE id='$id'";        
    } else {
        
        echo json_encode(["success" => false, "message" => "Category update allowed only for signup users"]);
        exit;
    }

    if (mysqli_query($conn, $query)) {
        echo json_encode(["success" => true, "message" => "Category updated"]);
    } else {
        echo json_encode(["success" => false, "message" => "Update failed"]);
    }

} else {
    echo json_encode(["success" => false, "message" => "Invalid input"]);
}
?>
