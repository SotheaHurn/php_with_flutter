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
$id = $data['id'];
$image = $data['image'];
$name = $data['name'];
$categoryId = $data['category_id'];
$brandId = $data['brand_id'];
$modelId = $data['model_id'];
$qty = $data['qty'];
$price = $data['price'];
$supplierId = $data['supplier_id'];
$sql = "UPDATE product SET image='$image',name='$name',supplier_id='$supplierId',category_id='$categoryId',brand_id='$brandId',model_id='$modelId',qty=$qty,price=$price WHERE id='$id'";
$result = $connect->query($sql);
if (!$result) {
    die('Error get data');
}
