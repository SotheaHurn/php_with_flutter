<?php
$host = 'localhost';
$username = 'root';
$db = 'crud_php';
$password = 'mysql';

$connect = new mysqli($host, $username, $password, $db);
if ($connect->connect_error) {
    die("Error Connect to DB" . $connect->connect_error);
}

$name = '';
$age = '';
$address = '';
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = $_POST['name'];
    $age = $_POST['age'];
    $address = $_POST['address'];
    if ($name == '' || $age == '' || $address == '') {
        echo "
            <script>
                alert('All Field Can Not Empty');
            </script>
        ";
    }

    $sql = "INSERT INTO user (name,age,address)  VALUES('$name','$age','$address')";
    $result = $connect->query($sql);
    if (!$result) {
        die('Error insert data');
    }
    header('location: ./index.php');
    exit;
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
        <h1>Add User</h1>
        <form method='POST'>
            <input placeholder="Name ..." name="name" value="<?php echo $name ?>" />
            <input placeholder="Age ..." name="age" value="<?php echo $age ?>" />
            <input placeholder="Address ..." name="address" value="<?php echo $address ?>" />
            <button class='add' type='submit'>Add</button>
        </form>
    </div>
</body>

</html>