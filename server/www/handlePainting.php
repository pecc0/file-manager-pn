<?php
session_start();
if ($_SESSION['command']=='imgsave' && isset($GLOBALS["HTTP_RAW_POST_DATA"]))
{
	// get bytearray
	$jpg = $GLOBALS["HTTP_RAW_POST_DATA"];
	
	$myFile = $_SESSION['userDir'] . '/' . $_SESSION['parameter'];
	$fh = @fopen($myFile, 'w');
	if (!$fh) {
		echo "error:cantOpen";
		die;
	}
	fwrite($fh, $jpg);
	fclose($fh);
	echo $_SESSION['parameter']; 
}
?>