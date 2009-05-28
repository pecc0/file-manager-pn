<?php
	//echo 'login -> $_REQUEST ';
	//print_r($_REQUEST);
	
	include 'securedHeader.php';
	
	echo $_SERVER['HTTP_USER_AGENT'];
	die;
	
	include 'loginCheck.php';
	if (!file_exists($usersHome . '/' . $user)) 
	{
		printf("userNotExist(%s)", $user);
		die;
	}
	chdir(realpath($usersHome . '/' . $user));
	$doc = new DOMDocument();
	$doc->load($confXml);
	$xp = new DOMXPath($doc);
	
	$rpass = $xp->evaluate("string(/UserConf/Pass)"); 
	
	if ($rpass != $password)
	{
		echo "wrongPass";
		die;
	}
	//session_start();
	include 'getIP.php';
	$_SESSION['REMOTE_IP'] = getip();
	$_SESSION['UNAME'] = $user;
	echo "OK";
	
	//echo $_SESSION['REMOTE_IP'];

	//realpath()
?>