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
 
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        return json_error("Connection Failed", -1);
    }

    if(!isset($_GET['code']))
        return json_error("No 'code' passed!", -1);
    $query = "SELECT Verified FROM $table WHERE ID = '$_GET[id]' AND Code = '$_GET[code]'";
    $result = $conn->query($query);

    if(!$result)
    {
        json_error($query, -2);
    }
    
    if($row = $result -> fetch_assoc())
    {
        if($row['Verified'] >= 1)
            json_error("Account already verified!", 1);

        $query = "UPDATE $table SET Verified = 1 WHERE ID = $_GET[id]";
        $result = $conn->query($query);

        if(!$result)
        {
            json_error($query, -2);
        }
        json_error("Verifiction complete!", 0);
    }
    else
    {
        json_error("Invalid Link!", -2);
    }
    return json_error("User not found", -1);
?>