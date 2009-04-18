<?php
	//session_start();
	//print_r($_SESSION);
	//session_destroy();
	echo session_save_path();
	echo "---" . session_id();
	echo SID;
?>
<html>
	<body>
	
		<form method="POST" action="login.php">
		  Username: <input type="text" name="user" size="15" /><br />
		  Password: <input type="password" name="pass" size="15" /><br />
		  <div align="center">
		    <p><input type="submit" value="Login" /></p>
		  </div>
		</form>
	</body>

</html>