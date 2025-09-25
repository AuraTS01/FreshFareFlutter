<?php
include 'database.php';

//Fetch signup users
$signupQuery = "SELECT id, username AS name, email, mob_num AS phone, category 
                FROM fresh_fare_signup";
$signupResult = mysqli_query($conn, $signupQuery);

$users = [];
if ($signupResult) {
    while ($row = mysqli_fetch_assoc($signupResult)) {
        $row['source'] = "signup"; 
        $users[] = $row;
    }
}

//Fetch enrolled companies
$companyQuery = "SELECT id, company_name AS name, email, mobile AS phone, selling_items AS category 
                 FROM company_registration";
$companyResult = mysqli_query($conn, $companyQuery);

if ($companyResult) {
    while ($row = mysqli_fetch_assoc($companyResult)) {
        $row['source'] = "company"; 
        $users[] = $row;
    }
}

echo json_encode($users);
?>
