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
    $table = "messages";
 
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

    if(!isset($data['Sender']))
        return json_error("No 'Sender' passed!", -1);
    if(!isset($data['Receiver']))
        return json_error("No 'Receiver' passed!", -1);
    if(!isset($data['Message']))
        return json_error("No 'Message' passed!", -1);

    $data['Message'] = RemoveSpecialChar($data['Message']);

    $query = "INSERT INTO $table (Sender,Receiver, Message) VALUES ($data[Sender],$data[Receiver], '$data[Message]');";
    $result = $conn->query($query);
    
    if(!$result)
    {
        json_error("Failed! Unknown error", -2);
    }
    $rows = array();
    $messageID = $conn->insert_id;
    return json_error("Added", $messageID);

    function RemoveSpecialChar($str) { 
        $res = str_replace( array( '\'', '"', 
        ';'), ' ', $str); 
        return $res; 
    } 
?>