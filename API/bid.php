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
    $table = "bids";
 
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

    if(!isset($data['RequestID']))
        return json_error("No 'RequestID' passed!", -1);
    if(!isset($data['UserID']))
        return json_error("No 'UserID' passed!", -1);
    if(!isset($data['Amount']))
        return json_error("No 'Amount' point passed!", -1);


    $result = $conn->query("INSERT INTO $table (request, amount, user) VALUES ('$data[RequestID]', '$data[Amount]', '$data[UserID]')");

    if(!$result)
    {
        return json_error("Already exits!", 0);
    }

    return json_error("Added", $data['RequestID']);
?>