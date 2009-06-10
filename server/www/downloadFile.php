<?php
//error_log(print_r($_GET, true));
session_start();

//error_log(print_r($_SESSION, true));
//error_log(session_id());
if ($_SESSION['command']=='download') {
	//error_log('file ok');
	//error_log(print_r($_FILES, true));
	//error_log($_SESSION['userDir'] . '/' . $_POST['serverfile']);
	
	
	/*
	$tempdir = $tempDirectory . '/' . session_id();
	delete_file($tempdir);
	mkdir($tempdir);
	if ($_SESSION['parameter'] == "<raw_post_data>") {
	} else {
		$myFile = $_SESSION['userDir'] . '/' . $_SESSION['parameter'];
		error_log('$myFile=' . $myFile);
		copy($myFile, $tempdir . '/' . basename($myFile));
		echo '/tmp/' . session_id() . '/' . basename($myFile);
	}
	*/
	
	$myFile = $_SESSION['userDir'] . '/' . $_SESSION['parameter'];
	$fh = @fopen($myFile, 'r');
	if (!$fh) {
		echo "Failed to open file";
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
} else {
	echo "Invalid session";
}
?>