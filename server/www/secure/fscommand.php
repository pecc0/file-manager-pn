<?php
$suppressDirList=true;
include 'listdir.php';

function delete_file($fname) {
	if (is_dir($fname)) {
		$dir_handle = opendir($fname);
		if (!$dir_handle)
			return false;
		while($file = readdir($dir_handle)) {
			if ($file != "." && $file != "..") {
				if (!delete_file($fname . "/" . $file)) {
					return false;
				}
			}
		}
		closedir($dir_handle);
		rmdir($fname);
	} else {
		if (!@unlink($fname)) {
			return false;
		}
	}
	return true;
}

checkPath();
chdir($path);
if ($_POST["command"]=="mkdir") {
	if (!mkdir($selectedFile)) {
		echo "error:mkdirError(" . $selectedFile . ")";
		die;
	}
} else if ($_POST["command"]=="delete") {
	foreach(split(";", $_POST["parameter"]) as $file) {
		if (strlen($file) > 0) {
			if (!delete_file($file)) {
				echo "error:deleteFile(" . $file . ")";
				die;
			}
		}
	}
}
printDirListing();
?>