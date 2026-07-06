<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>UiTM PTAR e-Library | Homepage</title>
	<style>
		body {
			margin: 0px;
			padding: 0px;
			background: #f6f6ff;
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
		}

		.top-bar {
			background: black;
			margin: 0px;
			padding: 0px;
			height: auto;
			display: flex;
			justify-content: flex-end;
		}

		.button {
			margin: 0;
			padding: 20px;
			color: white;
			background: black;
            text-decoration: none;
            transition: background 0.3s ease;
		}

        .button:hover, .content-button:hover {
            background: #333333;
        }

		.content-intro {
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
            padding: 40px 20px;
            align-items: center;
            min-height: 70vh;
		}

		.row {
			min-width: 50%;
			flex-grow: 1;
            padding: 20px;
            box-sizing: border-box;
		}

        .welcome-text {
            font-size: 3rem; 
            font-weight: bold;
        }

        .library-title {
            font-size: 1.5rem;
            color: #555;
            margin-bottom: 30px;
        }

		.content-button {
			text-decoration: none;
			color: white;
			padding: 12px 24px;
			background: black;
            border-radius: 4px; 
            display: inline-block;
            transition: background 0.3s ease;
		}
	</style>
</head>
<body>
    <header class='top-bar'>
		<a class='button' href='login.html'>SIGN IN</a>
	</header>
	
    <main class="content-intro">
		<div class='row welcome-text'>WELCOME</div>
		<div class='row'>
			<div class="library-title">UiTM PTAR e-Library System</div>
			<div>
				<a class="content-button" href='page-browse-not-log.html'>BROWSE ></a>
			</div>
		</div>
	</main>
</body>
</html>
