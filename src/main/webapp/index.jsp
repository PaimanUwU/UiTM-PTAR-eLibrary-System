
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
<body class="background">
	<div class="center form-div">
		<span class="center-form">
			<h2>Library Login</h2>

			<form class="form" action="login" method="post">
				<label for="uname"><b>Username</b></label><br>
				<input type="text" placeholder="Enter Username" name="uname" required><br>
				<label for="psw"><b>Password</b></label><br>
				<input type="Password" placeholder="Enter Password" name="psw" required><br>
				<span id='password_error'></span><br>

				<button type="submit">Login</button>
			</form>
		</span>
	</div>
</body>
</html>
