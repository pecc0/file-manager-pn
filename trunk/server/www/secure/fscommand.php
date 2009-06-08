<?php
$suppressDirList=true;
include 'listdir.php';
include 'constants.php';
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

function local_path_encoded($absolute) {
	global $userPath;
	return urlencode(substr($absolute, strlen($userPath)));
}

function copy_file($src, $dst) {
	global $userPath;
	if (is_dir($src)) {
		$dir_handle = opendir($src);
		if (!$dir_handle)
			return false;
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
	return true;
}

function get_new_name($file) {
	$i = 0;
	while (file_exists($file . "_copy" . $i)) {
		$i++;
	}
	return $file . "_copy" . $i;
}

checkPath();
chdir($path);
if ($_POST["command"]=="mkdir") {
	if (!mkdir($selectedFile)) {
		echo "error:mkdirError(" . urlencode($selectedFile) . ")";
		die;
	}
} else if ($_POST["command"]=="delete") {
	foreach(split(";", $_POST["parameter"]) as $file) {
		if (strlen($file) > 0) {
			if (!delete_file($file)) {
				echo "error:deleteFile(" . urlencode($file) . ")";
				die;
			}
		}
	}
} else if ($_POST["command"]=="copy") {
	
	$destDir = $usersHome . '/' . $user . '/' . $_POST["destDir"];
	
	$destDir = realpath($destDir);
	if ($destDir == "") {
		echo "error:" . "destNotFound(" . urlencode($destDir) . ")";
		die;
	}
	if (substr_compare($userPath, $destDir, 0, strlen($userPath)) != 0) {
		echo "error:" . $userPath . "!=" . $destDir;
		die;
	}
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
}
printDirListing();
?>