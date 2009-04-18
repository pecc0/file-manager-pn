<?php
	//$_POST["user"]
	//print_r($_SERVER);
	//echo $_ENV["HOME"];
	//print_r($_ENV);
	
	
	include 'loginCheck.php';
	//echo dir('.');
	//echo $_SERVER["USERS_HOME"]
	//echo $_POST["user"];
	chdir(realpath($usersHome));
	if (file_exists($user)) 
	{
		printf(getString("userExist"), $user);
		die;
	}
	mkdir($user);
	chdir($user);
	$doc = new DOMDocument('1.0');
	// we want a nice output
	$doc->formatOutput = true;

	$root = $doc->createElement("UserConf");
	$root = $doc->appendChild($root);
	$name = $doc->createElement("Name");
	$name = $root->appendChild($name);
	$name-> appendChild($doc->createTextNode($user));
	$pass = $root->appendChild($doc->createElement("Pass"));
	$pass -> appendChild($doc->createTextNode($password));
	$doc->save($confXml);
	echo getString("regSuccessful");
	//mkdir('pdp');
	//exists($usersHome . $_POST["user"]);
?>