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
$id = $data['id'];
if ($name != '') {
    $sql = "UPDATE model SET name='$name' WHERE id='$id'";
    $result = $connect->query($sql);
    if (!$result) {
        die('Error get data');
    }
}
