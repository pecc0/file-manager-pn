<?php
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
?>