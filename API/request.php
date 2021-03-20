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
    $table = "requests";
 
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

    if(!isset($data['User']))
        return json_error("No 'User' passed!", -1);
    if(!isset($data['Start']))
        return json_error("No 'Start' point passed!", -1);
    if(!isset($data['End']))
        return json_error("No 'End' point passed!", -1);
    if(!isset($data['Weight']))
        return json_error("No 'Weight' passed!", -1);
    if(!isset($data['Description']))
        return json_error("No 'Description' passed!", -1);
    if(!isset($data['Image']))
        return json_error("No 'Image' passed!", -1);

    $result = $conn->query("INSERT INTO $table (User, Start, End, Weight, Description) VALUES ($data[User], '$data[Start]', '$data[End]', $data[Weight], '$data[Description]')");

    if(!$result)
    {
        return json_error("Already exits!", 0);
    }
    $requestID = $conn->insert_id;
    
    $lName = "../Images/R/".$requestID.".jpg";
    
    file_put_contents($lName, file_get_contents($data['Image']));
    return json_error("Added", $requestID);
?>