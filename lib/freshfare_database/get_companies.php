<?php
include 'database.php';

$sql = "SELECT * FROM company_registration";
$result = mysqli_query($conn, $sql);

$companies = array();
while ($row = mysqli_fetch_assoc($result)) {
    $companies[] = $row;
}

echo json_encode($companies);
?>
