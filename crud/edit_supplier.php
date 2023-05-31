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
$name = $data['name'];
$profile = $data['profile'];
$sex = $data['sex'];
$dob = $data['dob'];
$phone = $data['phone'];
$sql = "UPDATE supplier SET profile='$profile',name='$name',sex='$sex',dob='$dob',phone='$phone' WHERE id='$id'";
$result = $connect->query($sql);
if (!$result) {
    die('Error get data');
}
