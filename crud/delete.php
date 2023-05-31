<?php
$host = 'localhost';
$username = 'root';
$db = 'crud_php';
$password = 'mysql';

$connect = new mysqli($host, $username, $password, $db);
if ($connect->connect_error) {
    die("Error Connect to DB" . $connect->connect_error);
}

if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $sql = "DELETE FROM user WHERE id=$id";
    $connect->query($sql);
}
header('location: ./index.php');
