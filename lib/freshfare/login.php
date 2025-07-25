<?php
   $db_Server = "localhost";
   $db_user = "root";
   $db_pass = "";
   $db_name = "freshfare_db";
   $conn = "";

   $conn = mysqli_connect($db_Server,
                          $db_user,
                          $db_pass,
                          $db_name);

    // if($conn){
    //     echo"You are connected";
    // }                      
    // else{
    //     echo"not connected";
    // }
    $username = $_POST['username'];
    $email = $_POST['email'];
    $mobile = $_POST['mobile'];
    $password = $_POST['password'];

    $sql = "SELECT * FROM user WHERE username = '".$username."' AND  email = '".$email."' AND mobile = '".$mobile."'  AND password = '".$password."' ";

    $result = mysqli_query($db,$sql);
    $count = mysqli_num_rows($result);

    if ($count == 1) {
	    echo json_encode("Error");
    }else{
	    $insert = "INSERT INTO user(username,email,mobile,password)VALUES('".$username."','".$email."','".$mobile."','".$password."')";
	    $query = mysqli_query($db,$insert);
	    if ($query) {
		     echo json_encode("Success");
	    }
    }
?>