<?php
$host = 'localhost';
$username = 'root';
$db = 'crud_php';
$password = 'mysql';

$connect = new mysqli($host, $username, $password, $db);
if ($connect->connect_error) {
    die("Error Connect to DB" . $connect->connect_error);
}

$sql = 'SELECT * FROM user';
$result = $connect->query($sql);
if (!$result) {
    die('Error get data');
}
$res = [];
while ($row = $result->fetch_assoc()) {
    $res[] = $row;
};
$data = json_decode(file_get_contents('php://input'),true);
echo json_encode($data['name']);
