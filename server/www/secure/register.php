<?php
	//$_POST["user"]
	//print_r($_SERVER);
	//echo $_ENV["HOME"];
	//print_r($_ENV);
	include 'texts.php';
	include 'constants.php';
	$user=$_POST["user"];
	if (!ereg("^[a-zA-Z0-9]+$", $user)){
		printf(getString("badStr"), $user);
		die;
	}
	$password = $_POST["pass"];
	if (!ereg("^.+$", $password)){
		printf(getString("badPass"), $password);
		die;
	}
	//echo dir('.');
	//echo $_SERVER["USERS_HOME"]
	//echo $_POST["user"];
	chdir($usersHome);
	if (file_exists($user)) 
	{
		printf(getString("userExist"), $password);
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
$pass -> appendChild($doc->createTextNode($_POST["pass"]));
$doc->save("conf.xml");

	//mkdir('pdp');
	//exists($usersHome . $_POST["user"]);
?>