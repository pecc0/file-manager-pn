﻿<?php 

//print_r($_SESSION);
//error_log('txt'. $TEXTS_ARRAY . ' ' . print_r($TEXTS_ARRAY));
//error_log("dump". var_dump($GLOBALS));
include 'keys.php';
$key = shm_attach(1);
echo 'aaaa->' . shm_get_var($key, $shmTextsID);
//if (!isset()) {
	error_log("texts created");
	$_SESSION['TEXTS_ARRAY'] = array();
	$_SESSION['TEXTS_ARRAY']["bg"]["badStr"] = "Лош стринг: \"%s\"";
//}
function getText($textId)
{
	return $_SESSION['TEXTS_ARRAY']["bg"][$textId];
}

?>