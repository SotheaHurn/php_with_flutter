<?php
$hostname = 'localhost';
$username = 'root';
$database = 'product_my_api';
$password = 'mysql';

try {
    // Create a new PDO instance
    $pdo = new PDO("mysql:host=$hostname;dbname=$database;charset=utf8", $username, $password);

    // Set PDO error mode to exception
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Optionally, set additional PDO attributes if needed
    // $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

    $data = json_decode(file_get_contents('php://input'), true);
    $image = $data['image'];
    $name = $data['name'];
    $supplierId = $data['supplier_id'];
    $categoryId = $data['category_id'];
    $brandId = $data['brand_id'];
    $modelId = $data['model_id'];
    $qty = $data['qty'];
    $price = $data['price'];
    date_default_timezone_set("Asia/Phnom_Penh");
    $currentDate = date("Y-m-d H:i:s");
    $sql = "INSERT INTO product (image,name,supplier_id,category_id,brand_id,model_id,price,qty,create_at) VALUES(:image, :name, :supplierId, :categoryId, :brandId, :modelId, :qty, :price, :currentDate)";

    $stmt = $pdo->prepare($sql);
    $stmt->bindParam(':image', $image);
    $stmt->bindParam(':name', $name);
    $stmt->bindParam(':supplierId', $supplierId);
    $stmt->bindParam(':categoryId', $categoryId);
    $stmt->bindParam(':brandId', $brandId);
    $stmt->bindParam(':modelId', $modelId);
    $stmt->bindParam(':qty', $qty);
    $stmt->bindParam(':price', $price);
    $stmt->bindParam(':currentDate', $currentDate);
    $stmt->execute();
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
