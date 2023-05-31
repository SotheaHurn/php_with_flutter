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
$name = $data['name'];
$image = $data['image'];
if ($name != '' && $image != '') {
    $sql = "INSERT INTO category (name,image) VALUES('$name','$image')";
    $result = $connect->query($sql);
    if (!$result) {
        die('Error get data');
    }
}
