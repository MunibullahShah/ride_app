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

    $query = "SELECT User, MAX(DateSent) AS Date, Name FROM (SELECT Sender AS User, DateSent, s.Name As Name FROM messageTop AS a INNER JOIN users AS s ON a.Sender = s.ID WHERE (Receiver = $data[User])
    UNION
    SELECT Receiver AS User, DateSent, s.Name As Name FROM messageTop AS a INNER JOIN users AS s ON a.Receiver = s.ID WHERE (Sender = $data[User])) AS x GROUP BY User ORDER BY Date";
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