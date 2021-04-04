<?php

    function json_error($message, $code)
    {
        $arr = array('message' => $message, 'code' => $code);
        exit(json_encode($arr));
    }
	$servername = "localhost";
    $username = "itemjetc_app";
    $password = "&E}Bv6Wc=Ctf";
    $dbname = "itemjetc_app";
    $table = "users";
 
    $json = file_get_contents('php://input');
    $data = json_decode($json,true);
     
    if($data == null)
        return json_error("Inavlid json passed!: \n$json", -1);
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        return json_error("Connection Failed", -1);
    }

    if(!isset($data['email']))
        return json_error("No 'email' passed!", -1);
    if(!isset($data['User']))
        return json_error("No 'User' passed!", -1);

    $code = random_int(1000, 9999);
    $result = $conn->query("UPDATE $table SET Email = '$data[email]' WHERE ID = $data[User]");

    if(!$result)
    {
        return json_error("Error!", 0);
    }
    return json_error("Updated", 1);
?>