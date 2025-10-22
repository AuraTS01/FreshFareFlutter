<?php
header('Content-Type: application/json');

// Database credentials
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "FreshFare";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => "Connection failed: " . $conn->connect_error
    ]);
    exit();
}

$companies = [];
$sql = "SELECT * FROM company_registration";
$result = $conn->query($sql);

if ($result === false) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => "Error fetching companies: " . $conn->error
    ]);
    $conn->close();
    exit();
}

while ($row = $result->fetch_assoc()) {
    $companyId = $row['company_id'];
    $sellingItemsRaw = trim($row['selling_items'] ?? '');
    $items = [];

    if (!empty($sellingItemsRaw)) {
        // Split by comma and handle special items like "Chicken (With Skin, Without Skin)"
        $itemList = array_map('trim', explode(',', $sellingItemsRaw));

        foreach ($itemList as $item) {
            // Normalize item names
            $normalized = strtolower(str_replace([' ', '-', '(', ')'], '_', $item));

            // Default to 0 if not found
            $priceColumn = null;
            $itemDisplayName = $item;
            $priceValue = 0.0;

            // Match names to item_price columns
            if (strpos($normalized, 'chicken_with_skin') !== false) {
                $priceColumn = 'chicken_with_skin_price';
            } elseif (strpos($normalized, 'chicken_without_skin') !== false) {
                $priceColumn = 'chicken_without_skin_price';
            } elseif (strpos($normalized, 'prawn') !== false) {
                $priceColumn = 'prawn_price';
            } elseif (strpos($normalized, 'mutton_boti') !== false) {
                $priceColumn = 'mutton_boti_price';
            } elseif (strpos($normalized, 'mutton_liver') !== false) {
                $priceColumn = 'mutton_Liver_price';
            } elseif (strpos($normalized, 'mutton') !== false) {
                $priceColumn = 'mutton_price';
            } elseif (strpos($normalized, 'beef_boti') !== false) {
                $priceColumn = 'beef_boti_price';
            } elseif (strpos($normalized, 'beef_liver') !== false) {
                $priceColumn = 'beef_liver_price';
            } elseif (strpos($normalized, 'beef') !== false) {
                $priceColumn = 'beef_price';
            } elseif (strpos($normalized, 'fish') !== false) {
                $priceColumn = 'fish_price';
            } elseif (strpos($normalized, 'duck') !== false) {
                $priceColumn = 'duck_price';
            } elseif (strpos($normalized, 'kadai') !== false) {
                $priceColumn = 'kadai_price';
            }

            // Fetch item price
            if ($priceColumn) {
                $priceQuery = "SELECT `$priceColumn` FROM item_price WHERE company_id = ?";
                $stmt = $conn->prepare($priceQuery);
                $stmt->bind_param("i", $companyId);
                $stmt->execute();
                $priceResult = $stmt->get_result();
                if ($priceResult && $priceRow = $priceResult->fetch_assoc()) {
                    $priceValue = (float)$priceRow[$priceColumn];
                }
                $stmt->close();
            }

            $items[] = [
                'name' => $itemDisplayName,
                'price' => $priceValue
            ];
        }
    }

    $companies[] = [
        'company_id' => $row['company_id'],
        'company_name' => $row['company_name'],
        'company_address' => $row['company_address'],
        'email' => $row['email'],
        'mobile' => $row['mobile'],
        'selling_items' => $items
    ];
}

echo json_encode([
    'success' => true,
    'companies' => $companies
], JSON_PRETTY_PRINT);

$conn->close();
?>
