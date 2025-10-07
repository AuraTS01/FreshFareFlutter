<?php
include 'database.php';

if (!isset($_POST['company_id'])) {
    echo json_encode(["error" => "company_id missing"]);
    exit;
}

$company_id = $_POST['company_id'];

// Optional: sanitize input
$company_id = mysqli_real_escape_string($conn, $company_id);

$sql = "SELECT * FROM item_price WHERE company_id = '$company_id'";
$result = mysqli_query($conn, $sql);

$products = array();
while ($row = mysqli_fetch_assoc($result)) {
    $products[] = $row;
}

echo json_encode($products);
?>
