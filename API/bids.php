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

    $query = "";

    if(isset($data['UserID']))
    {
        $query = "SELECT amount as Amount, user AS UserID FROM $table WHERE request IN (SELECT ID FROM requests WHERE User = $data[UserID] AND Completed = 0)";
    }
    else if(isset($data['ID']))
    {
        $query = "SELECT amount as Amount, user AS UserID FROM $table WHERE request = $data[ID]";
    }
    else
        return json_error("No 'ID' or 'UserID' passed!", -1);
    
    
    
    $result = $conn->query($query);

    if(!$result)
    {
        json_error("Failed! Unknown error", -2);
    }
    $rows = array();

    //retrieve and print every record
    while($r = $result->fetch_assoc()){
        $rows[] = array('data' => $r);
    }

    // now all the rows have been fetched, it can be encoded
    exit(json_encode($rows));
?>