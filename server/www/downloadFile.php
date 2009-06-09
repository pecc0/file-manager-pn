<?php
//error_log(print_r($_FILES, true));
session_start();

//error_log(print_r($_POST, true));
if ($_SESSION['command']=='download') {
	//error_log('file ok');
	//error_log(print_r($_FILES, true));
	//error_log($_SESSION['userDir'] . '/' . $_POST['serverfile']);
	
	$myFile = $_SESSION['userDir'] . '/' . $_SESSION['parameter'];
	error_log($myFile);
	$fh = @fopen($myFile, 'r');
	if (!$fh) {
		echo "failed to open file";
		die;
	}
	$theData = fread($fh, filesize($myFile));
	fclose($fh);
	
	header('Content-Type: application/octet-stream');
	header("Content-Disposition: attachment; filename=".basename(realpath($myFile)));
	echo $theData;
	error_log("sent");
	session_unset();
	session_destroy();
}
?>