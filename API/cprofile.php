<?php

    function json_error($message, $code)
    {
        $arr = array('message' => $message, 'code' => $code);
        exit(json_encode($arr));
    }
 
    $json = file_get_contents('php://input');
    $data = json_decode($json,true);
     
    if($data == null)
        return json_error("Inavlid json passed!: \n$json", -1);
    if(!isset($data['User']))
        return json_error("No 'User' passed!", -1);
    if(!isset($data['Picture']))
        return json_error("No 'Picture' passed!", -1);


    $sName = "../Images/S/".$data['User'].".jpg";
    
    file_put_contents($sName, file_get_contents($data['Picture']));
    return json_error("Updated", 1);
?>