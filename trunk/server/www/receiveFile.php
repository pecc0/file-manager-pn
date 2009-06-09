<?php
//error_log(print_r($_FILES, true));
session_start();

//error_log(print_r($_POST, true));
if ($_SESSION['command']=='upload' && $_SESSION['parameter']==$_FILES['Filedata']['name'].$_FILES['Filedata']['size']) {
	//error_log('file ok');
	//error_log(print_r($_FILES, true));
	//error_log($_SESSION['userDir'] . '/' . $_POST['serverfile']);
	move_uploaded_file($_FILES['Filedata']['tmp_name'], $_SESSION['userDir'] . '/' . $_POST['serverfile'] . $_FILES['Filedata']['name']);

	session_unset();
	session_destroy();
}
?>