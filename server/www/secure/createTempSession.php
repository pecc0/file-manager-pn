<?php
	include 'securedHeader.php';
	include 'constants.php';
	include 'loginCheck.php';
	$userDir=$usersHome . '/' . $_SESSION['UNAME'];
	
	session_regenerate_id();
	//print_r($_SESSION); 
	session_unset();
	//print_r($_SESSION);
	$_SESSION['command']=$_POST['command'];
	$_SESSION['parameter']=$_POST['parameter'];
	$_SESSION['userDir']=$userDir;
	echo SID;
	
?>