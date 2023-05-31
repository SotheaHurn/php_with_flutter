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

    $sql = "SELECT p.*,b.name AS 'brand_name',c.name AS 'category_name',m.name AS 'model_name',s.name AS 'supplier_name' FROM ((((product p INNER JOIN category c ON p.category_id=c.id) INNER JOIN brand b ON p.brand_id=b.id) INNER JOIN model m ON p.model_id=m.id) LEFT JOIN supplier s ON p.supplier_id=s.id)";

    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $res = [];
    foreach ($results as $row) {
        $res[] = $row;
    }
    echo json_encode($res);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
