<?php
$host = 'localhost';
$username = 'root';
$password = 'mysql';
$db = 'product_my_api';

$connect = new mysqli($host, $username, $password, $db);
if ($connect->connect_error) {
    die("Error Connect to DB" . $connect->connect_error);
}

$sql = "SELECT p.*,b.name AS 'brand_name',c.name AS 'category_name',m.name AS 'model_name',s.name AS 'supplier_name' FROM ((((product p INNER JOIN category c ON p.category_id=c.id) INNER JOIN brand b ON p.brand_id=b.id) INNER JOIN model m ON p.model_id=m.id) LEFT JOIN supplier s ON p.supplier_id=s.id)";
$result = $connect->query($sql);
if (!$result) {
    die('Error get data');
}
$res = [];
while ($row = $result->fetch_assoc()) {
    $res[] = $row;
}
echo json_encode($res);
