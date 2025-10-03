<?php
include 'database.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

$input = json_decode(file_get_contents("php://input"), true);

$company_name    = $input['company_name']    ?? ($_POST['company_name'] ?? '');
$company_address = $input['company_address'] ?? ($_POST['company_address'] ?? '');
$email           = $input['email']           ?? ($_POST['email'] ?? '');
$mobile          = $input['mobile']          ?? ($_POST['mobile'] ?? '');
$selling_items   = $input['selling_items']   ?? ($_POST['selling_items'] ?? '');
$signup_id       = $input['signup_id']       ?? ($_POST['signup_id'] ?? '');

if (empty($company_name) || empty($email) || empty($mobile) || empty($signup_id)) {
    echo json_encode(["status" => "Error", "message" => "Missing required fields"]);
    exit;
}

$signup_id = (int)$signup_id;

$checkSignup = $conn->prepare("SELECT id FROM fresh_fare_signup WHERE id = ?");
$checkSignup->bind_param("i", $signup_id);
$checkSignup->execute();
$result = $checkSignup->get_result();

if ($result->num_rows == 0) {
    echo json_encode(["status" => "Error", "message" => "Invalid signup_id"]);
    exit;
}


$checkCompany = $conn->prepare("SELECT id FROM company_registration WHERE email = ? OR mobile = ?");
$checkCompany->bind_param("ss", $email, $mobile);
$checkCompany->execute();
$result2 = $checkCompany->get_result();

if ($result2->num_rows >= 1) {
    echo json_encode(["status" => "Error", "message" => "Company already exists"]);
    exit;
}


$insert = $conn->prepare("INSERT INTO company_registration 
    (signup_id, company_name, company_address, email, mobile, selling_items) 
    VALUES (?, ?, ?, ?, ?, ?)");
$insert->bind_param("isssss",  $signup_id, $company_name, $company_address, $email, $mobile, $selling_items);

if ($insert->execute()) {
    echo json_encode([
        "status" => "Success",
        "message" => "Company registered successfully",
        "company_id" => $insert->insert_id
    ]);
} else {
    echo json_encode([
        "status" => "Error",
        "message" => $insert->error
    ]);
}

$insert->close();
$conn->close();
?>
