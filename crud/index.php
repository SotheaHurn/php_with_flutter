<?php
$host = 'localhost';
$username = 'root';
$db = 'crud_php';
$password = 'mysql';

$connect = new mysqli($host, $username, $password, $db);
if ($connect->connect_error) {
    die("Error Connect to DB" . $connect->connect_error);
}
?>

<!DOCTYPE html>
<html>

<head>
    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        td,
        th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }

        .container {
            width: 70%;
            margin: 5rem auto;
        }

        .head {
            background-color: grey;
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
    </style>
</head>

<body>
    <div class="container">
        <h2>PHP CRUD</h2>
        <button class="add">
            <a href="./add.php">Add</a>
        </button>
        <table>
            <tr>
                <th class="head">Name</th>
                <th class="head">Age</th>
                <th class="head">Address</th>
                <th class="head">Action</th>
            </tr>

            <?php
            $sql = 'SELECT * FROM user';
            $result = $connect->query($sql);
            if (!$result) {
                die('Error get data');
            }
            while ($row = $result->fetch_assoc()) {
                echo "
            <tr>
                <td>$row[name]</td>
                <td>$row[age]</td>
                <td>$row[address]</td>
                <td>
                    <button class='edit'>
                        <a href='./edit.php?id=$row[id]'>Edit</a>
                    </button>
                    <button class='delete'>
                        <a href='./delete.php?id=$row[id]'>Delete</a>
                    </button>
                </td>
            </tr>
                ";
            }
            ?>
        </table>
    </div>

</body>

</html>