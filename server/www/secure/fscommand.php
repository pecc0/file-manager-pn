<?php
$suppressDirList=true;
include 'listdir.php';
checkPath();
chdir($path);
if ($_POST["command"]=="mkdir") {
	if (!mkdir($selectedFile)) {
		echo "error:mkdirError";
		die;
	}
}
printDirListing();
?>