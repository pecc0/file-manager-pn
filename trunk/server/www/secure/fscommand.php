<?php

$suppressDirList=true;
include 'listdir.php';

include 'constants.php';
include 'loginCheck.php';

include 'fsUtils.php';

function local_path_encoded($absolute) {
	global $userPath;
	if (substr_compare($userPath, $absolute, 0, strlen($userPath)) != 0) {
		//the path is not absolute
		return urlencode($absolute);
	}
	return urlencode(substr($absolute, strlen($userPath)));
}

function copy_file($src, $dst) {
	global $userPath;
	if (is_dir($src)) {
		$dir_handle = opendir($src);
		if (!$dir_handle)
			return "readDir(" . local_path_encoded($src) . ")";
			
		if (!@mkdir($dst)) {
			return "error:mkdirFailed(" . local_path_encoded($dst) . ")";
		}
		while($file = readdir($dir_handle)) {
			if ($file != "." && $file != "..") {
				$result = copy_file($src . "/" . $file, $dst . "/" . $file);
				if ($result != "") {
					return $result;
				}
			}
		}
		closedir($dir_handle);
	} else {
		if (!@copy($src, $dst)) {
			return "error:copyFailed(" . local_path_encoded($src) . "," . local_path_encoded($dst) . ")";;
		}
	}
	return "";
}

function get_new_name($file) {
	$i = 0;
	while (file_exists($file . "_copy" . $i)) {
		$i++;
	}
	return $file . "_copy" . $i;
}

function get_dest_dir($destDir) {
	global $userPath, $usersHome, $user;
	
	$destDir = $usersHome . '/' . $user . '/' . $destDir;
	
	$destDir = realpath($destDir);
	if ($destDir == "") {
		echo "error:" . "destNotFound(" . local_path_encoded($destDir) . ")";
		die;
	}
	if (substr_compare($userPath, $destDir, 0, strlen($userPath)) != 0) {
		echo "error:" . $userPath . "!=" . $destDir;
		die;
	}
	return $destDir;
}

checkPath();
chdir($path);
if ($_POST["command"]=="mkdir") {
	if (!@mkdir($selectedFile)) {
		echo "error:mkdirError(" . local_path_encoded($selectedFile) . ")";
		die;
	}
} else if ($_POST["command"]=="delete") {
	foreach(split(";", $_POST["parameter"]) as $file) {
		if (strlen($file) > 0) {
			if (!@delete_file($file)) {
				echo "error:deleteFile(" . local_path_encoded($file) . ")";
				die;
			}
		}
	}
} else if ($_POST["command"]=="copy") {
	
	$destDir = get_dest_dir($_POST["destDir"]);
	foreach(split(";", $_POST["files"]) as $file) {
		if (strlen($file) > 0) {
			$dstFile = $file;
			if ($destDir == $path) {
				$dstFile=get_new_name($file);
			}
			$result = copy_file($file, $destDir . "/" . $dstFile);
			if ($result != "") {
				echo $result;
				die;
			}
		}
	}
} else if ($_POST["command"]=="move") {
	$destDir = get_dest_dir($_POST["destDir"]);
	$files = split(";", $_POST["files"]);
	foreach($files as $file) {
		if (strlen($file) > 0) {
			if (count($files) == 2) {
				$destFile = $destDir . "/" . basename($_POST["dest"]);
			} else {
				$destFile = $destDir . "/" . $file;
			}
			if (!@rename($file, $destFile)) {
				echo "error:moveFailed(" . local_path_encoded($file) . "," . local_path_encoded($destFile) . ")";
				die;
			}
		}
	}
}
chdir($path);
printDirListing();
?>