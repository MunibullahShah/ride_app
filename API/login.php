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
    if(!isset($data['pass']))
        return json_error("No 'number' passed!", -1);

    $data['pass']= hash('whirlpool', $data['pass']);
    $query = "SELECT * FROM $table WHERE Email = '$data[email]' AND Password = '$data[pass]'";
    $result = $conn->query($query);

    if(!$result)
    {
        json_error("Failed! Unknown error", -2);
    }
    
    if($row = $result -> fetch_assoc())
    {
        $userID = $row['ID'];
        $lName = "../Images/L/".$userID.".jpg";
        $sName = "../Images/S/".$userID.".jpg";

        $lType = pathinfo($lName, PATHINFO_EXTENSION);
        $sType = pathinfo($sName, PATHINFO_EXTENSION);

        $lisence = file_get_contents($lName);
        $selfie = file_get_contents($sName);

        $lisence64 = 'data:image/' . $lType . ';base64,' . base64_encode($lisence);
        $selfie64 = 'data:image/' . $sType . ';base64,' . base64_encode($selfie);
        $arr = array('message' => "Logged In", 'code' => $userID,'ID' => $userID, 'name' => $row['Name'],'contact' => $row['ContactNo'], 'verification' => $row['Verified'], 'lisence' => $lisence64, 'selfie' => $selfie64);
        exit(json_encode($arr));
    }
    return json_error("User not found", -1);
?>