<?php
$host = 'localhost';
$username = 'root';
$db = 'product_my_api';
$password = 'mysql';

$connect = new mysqli($host, $username, $password, $db);
if ($connect->connect_error) {
    die("Error Connect to DB" . $connect->connect_error);
}
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
$sql = "INSERT INTO product (image,name,supplier_id,category_id,brand_id,model_id,price,qty,create_at) VALUES('$image','$name','$supplierId','$categoryId','$brandId','$modelId','$qty','$price','$currentDate')";
$result = $connect->query($sql);
if (!$result) {
    die('Error get data');
}
