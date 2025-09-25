<?php
include 'database.php';

// Email of the logged-in company
$email = isset($_POST['email']) ? $_POST['email'] : '';

if (empty($email)) {
    echo json_encode(["status" => "Error", "message" => "Email is required"]);
    exit;
}

// Get company_id from email
$stmt = $conn->prepare("SELECT company_id FROM company_registration WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode(["status" => "Error", "message" => "No company found with this email"]);
    exit;
}

$company_id = $result->fetch_assoc()['company_id'];

// Collect prices from Flutter POST data
$prices = [
    "chicken_with_skin_price"    => isset($_POST['Chicken With Skin']) ? floatval($_POST['Chicken With Skin']) : null,
    "chicken_without_skin_price" => isset($_POST['Chicken Without Skin']) ? floatval($_POST['Chicken Without Skin']) : null,
    "mutton_price"               => isset($_POST['Mutton']) ? floatval($_POST['Mutton']) : null,
    "kadai_price"                => isset($_POST['Kadai']) ? floatval($_POST['Kadai']) : null,
    "beef_price"                 => isset($_POST['Beef']) ? floatval($_POST['Beef']) : null,
    "beef_boti_price"            => isset($_POST['Beef Boti']) ? floatval($_POST['Beef Boti']) : null,
    "beef_liver_price"           => isset($_POST['Beef Liver']) ? floatval($_POST['Beef Liver']) : null,
];

// Build dynamic SQL update
$columns = [];
$params = [];
$types = '';

foreach ($prices as $column => $value) {
    if ($value !== null) {
        $columns[] = "$column = ?";
        $params[] = $value;
        $types .= 'd';
    }
}

if (count($columns) === 0) {
    echo json_encode(["status" => "Error", "message" => "No prices provided"]);
    exit;
}

$types .= 'i';   
$params[] = $company_id;

$sql = "UPDATE item_price SET " . implode(", ", $columns) . " WHERE company_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param($types, ...$params);

if ($stmt->execute()) {
    echo json_encode(["status" => "Success", "message" => "Prices updated successfully"]);
} else {
    echo json_encode(["status" => "Error", "message" => $stmt->error]);
}

$stmt->close();
$conn->close();
?>
