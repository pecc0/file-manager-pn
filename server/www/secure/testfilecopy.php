<?php
include 'securedHeader.php';
$_SESSION['UNAME']="aa"
?>
<html>
	<body>
	
		<form method="POST" action="fscommand.php?<?php echo SID?>">
		<input type="hidden" name="command" value="copy"/>
		  Files: <input type="text" name="files" size="15" value="124"/><br />
		  destDir: <input type="text" name="destDir" size="15" value="/sad"/><br />
		  current: <input type="text" name="dir" size="15" value="/"/><br />
		  <div align="center">
		    <p><input type="submit" value="Login" /></p>
		  </div>
		</form>
	</body>

</html>