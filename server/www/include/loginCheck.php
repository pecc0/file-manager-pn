<?php

include 'texts.php';
include 'constants.php';

$user=$_POST["user"];

if (!ereg("^[a-zA-Z0-9]+$", $user)){
	printf(getString("badUser"), $user);
	die;
}

$password = $_POST["pass"];
if (!ereg("^.+$", $password)){
	printf(getString("shortPass"), $password);
	die;
}

?>