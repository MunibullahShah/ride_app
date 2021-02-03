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
     
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        return json_error("Connection Failed", -1);
    }

    if(!isset($data['email']))
        return json_error("No 'email' passed!", -1);
    if(!isset($data['number']))
        return json_error("No 'number' passed!", -1);
    if(!isset($data['pass']))
        return json_error("No 'pass' passed!", -1);
    if(!isset($data['lisence']))
        return json_error("No 'lisence' passed!", -1);
    if(!isset($data['selfie']))
        return json_error("No 'selfie' passed!", -1);

    $data['pass']= hash('whirlpool', $data['pass']);

    $code = random_int(1000, 9999);
    $result = $conn->query("INSERT INTO $table (Password, Email, ContactNo, Code) VALUES ('$data[pass]', '$data[email]', '$data[number]', $code)");

    if(!$result)
    {
        return json_error("Already exits!", 0);
    }
    $headers = "From: admin@itemjet.com";
    $userID = $conn->insert_id;

    mail($data['email'],"Ride App registration complete", "Please visit this link https://itemjetc.mywhc.ca/API/verify.php?id=$userID&code=$code\n\nThanks.", $headers);

    
    $lName = "../Images/L/".$userID.".jpg";
    $sName = "../Images/S/".$userID.".jpg";
    
    file_put_contents($lName, file_get_contents($data['lisence']));
    file_put_contents($sName, file_get_contents($data['selfie']));
    return json_error("Added", $userID);
?>