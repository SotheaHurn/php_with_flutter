<?php
$host = 'localhost';
$username = 'root';
$password = 'mysql';
$db = 'product_my_api';

$connect = new mysqli($host, $username, $password, $db);
if ($connect->connect_error) {
    die('Error Connect to DB ' . $connect->connect_error);
}

$sql = "SELECT * FROM supplier";
$result = $connect->query($sql);
if (!$result) {
    die('Error get data');
}
$res = [];
while ($row = $result->fetch_assoc()) {
    $res[] = $row;
}
echo json_encode($res);
