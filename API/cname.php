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

    if(!isset($data['name']))
        return json_error("No 'name' passed!", -1);
    if(!isset($data['User']))
        return json_error("No 'User' passed!", -1);

    $result = $conn->query("UPDATE $table SET Name = '$data[name]' WHERE ID = $data[User]");

    if(!$result)
    {
        return json_error("Error!", 0);
    }
    return json_error("Updated", 1);
?>