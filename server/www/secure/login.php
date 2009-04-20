<?php
	//echo 'login -> $_REQUEST ';
	//print_r($_REQUEST);
	include 'loginCheck.php';
	if (!file_exists($usersHome . '/' . $user)) 
	{
		printf(getString("userNotExist"), $user);
		die;
	}
	chdir(realpath($usersHome . '/' . $user));
	$doc = new DOMDocument();
	$doc->load($confXml);
	$xp = new DOMXPath($doc);
	
	$rpass = $xp->evaluate("string(/UserConf/Pass)"); 
	
	if ($rpass != $password)
	{
		echo getString("wrongPass");
		die;
	}
	session_start();
	include 'getIP.php';
	$_SESSION['REMOTE_IP'] = getip();
	$_SESSION['UNAME'] = $user;
	echo SID;
	//echo $_SESSION['REMOTE_IP'];

	//realpath()
?>