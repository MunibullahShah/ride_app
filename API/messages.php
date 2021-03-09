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
    if(!isset($data['Limit']))
        return json_error("No 'Limit' passed!", -1);
    if(!isset($data['Offset']))
        return json_error("No 'Offset' passed!", -1);

    $query = "SELECT DateSent, Sender, s.Name As SenderName, Receiver, r.Name AS ReceiverName, Message FROM $table AS a INNER JOIN users AS s ON a.Sender = s.ID INNER JOIN users AS r ON a.Receiver = r.ID WHERE (Sender = $data[Sender] AND Receiver = $data[Receiver]) OR (Sender = $data[Receiver] AND Receiver = $data[Sender]) ORDER BY DateSent DESC LIMIT $data[Offset],$data[Limit]";
    $result = $conn->query($query);
    
    if(!$result)
    {
        json_error("Failed! Unknown error", -2);
    }
    $rows = array();

    //retrieve and print every record
    while($r = $result->fetch_assoc()){
        // $rows[] = $r; has the same effect, without the superfluous data attribute
        $rows[] = array('data' => $r);
    }

    // now all the rows have been fetched, it can be encoded
    exit(json_encode($rows));
?>