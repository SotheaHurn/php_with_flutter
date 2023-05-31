<?php
$host = 'localhost';
$username = 'root';
$db = 'crud_php';
$password = 'mysql';

$connect = new mysqli($host, $username, $password, $db);
if ($connect->connect_error) {
    die("Error Connect to DB" . $connect->connect_error);
}

$id = '';
$name = '';
$age = '';
$address = '';
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (!isset($_GET['id'])) {
        header('location: ./index.php');
        exit;
    }
    $id = $_GET['id'];

    $sql = "SELECT * FROM user WHERE id=$id";
    $result = $connect->query($sql);
    $row = $result->fetch_assoc();
    if (!$row) {
        die('Error Get Data');
        header('location: ./index.php');
    }

    $name = $row['name'];
    $age = $row['age'];
    $address = $row['address'];
} else {
    $id = $_GET['id'];
    $name = $_POST['name'];
    $age = $_POST['age'];
    $address = $_POST['address'];
    if ($name == '' || $age == '' || $address == '') {
        echo "
            <script>
                alert('All Field Can Not Empty');
            </script>
        ";
        die();
    }
    $sql = "UPDATE user SET name='$name' , age='$age' , address='$address' WHERE id=$id";
    $result = $connect->query($sql);
    if (!$result) {
        echo "
            <script>
                alert('Could not update');
            </script>
        ";
    }
    header('location: ./index.php');
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <style>
        .container {
            width: 70%;
            margin: 5rem auto;
        }

        .head {
            background-color: gray;
            color: white;
        }

        button {
            padding: .5rem 1rem;
            cursor: pointer;
            border: none;
            color: white;
            border-radius: .2rem;
        }

        .edit {
            background-color: blue;
        }

        .delete {
            background-color: red;
        }

        .add {
            background-color: green;
            margin-bottom: 1rem;
        }

        a {
            color: white;
            text-decoration: none;
        }

        form {
            display: flex;
            flex-direction: column;
            width: 30rem;
            margin: auto;
        }

        input {
            padding: .5rem 2rem;
            margin-bottom: .5rem;
        }
    </style>
</head>

<body>
    <div class='container'>
        <h1>Update User</h1>
        <form method='POST'>
            <input placeholder="Name ..." name="name" value="<?php echo $name ?>" />
            <input placeholder="Age ..." name="age" value="<?php echo $age ?>" />
            <input placeholder="Address ..." name="address" value="<?php echo $address ?>" />
            <button class='edit' type='submit'>Update</button>
        </form>
    </div>
</body>

</html>