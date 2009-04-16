<?php
	//$_POST["user"]
	//print_r($_SERVER["USERS_HOME"]);
	//echo $_ENV["HOME"];
	//print_r($_ENV);
	include 'texts.php';
	if (!ereg("^[a-zA-Z0-9]+$", $_POST["user"])){
		printf(getText("badStr"), $_POST["user"]);
		die;
	}
	//echo $_SERVER["USERS_HOME"]
	echo $_POST["user"];
?>