<?php

include 'texts.php';
include 'constants.php';

$user=$_POST["user"];

if (!ereg("^[a-zA-Z0-9]+$", $user)){
	printf("badUser(%s)", urlencode($user));
	die;
}

$password = $_POST["pass"];
if (!ereg("^.+$", $password)){
	printf("shortPass(%s)", $password);
	die;
}

?>