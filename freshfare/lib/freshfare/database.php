<?php
    session_start();

    $_SESSION['user']= "live";

    $login_db =  new mysqli("localhost","root","","freshfare_db");


    if (isset($_POST['sign'])) {
        $username = $_POST['username'];
        $email = $_POST['email'];
        $mobile = $_POST['mobile'];
        $password = $_POST['password'];

        $sql = "SELECT * FROM user WHERE email = '$email' AND mobile = '$mobile'";

        $result = mysqli_query($login_db,$sql);
        $count = mysqli_num_rows($result);

        if ($count == 1) {
            echo json_encode("Error");
        }else{
            $insert = "INSERT INTO user (username,email,mobile,password) VALUES ('$username','$email','$mobile','$password')";
            $query = mysqli_query($db,$insert);
            if ($query) {
                echo json_encode("Success");
            }
        }
    }    
?>