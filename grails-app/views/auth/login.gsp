<%@ page contentType="text/html;charset=UTF-8" %>
<html style="max-height: 98vh; background-color: antiquewhite">
<head>
    <meta name="layout" content="main">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
    body {
        font-family: Arial, Helvetica, sans-serif;
    }

    /* Full-width input fields */
    input[type=text], input[type=password] {
        width: 100%;
        padding: 12px 20px;
        margin: 8px 0;
        display: inline-block;
        border: 1px solid #ccc;
        box-sizing: border-box;
    }

    /* Set a style for all buttons */
    button {
        background-color: #04AA6D;
        color: white;
        padding: 14px 20px;
        margin: 8px 0;
        border: none;
        cursor: pointer;
        width: 100%;
    }

    button:hover {
        opacity: 0.8;
    }

    /* Center the image and position the close button */
    .imgcontainer {
        text-align: center;
        margin: 24px 0 12px 0;
        position: relative;
    }

    img.avatar {
        width: 40%;
        border-radius: 50%;
    }

    .container {
        padding: 16px;
    }

    /* Modal Content/Box */
    .modal-content {
        background-color: #fefefe;
        margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
        border: 1px solid #888;
        width: 80%; /* Could be more or less, depending on screen size */
    }
    </style>
</head>

<body>
<section>
    <div style="max-height: 72vh">

        <div class="modal-content" style="max-width: 450px;background-color: bisque;border-radius: 34px;">
            <div class="imgcontainer">
                <img src="https://clipart-library.com/images/pT7K76y8c.jpg" alt="Avatar" class="avatar">
            </div>

            <div class="container">
                <label for="login_input"><b>User Email</b></label>
                <input id="login_input" type="text" placeholder="Enter Email" name="login_input">

                <label for="login_pass"><b>Password</b></label>
                <input id="login_pass" type="password" placeholder="Enter Password" name="login_pass">

                <button id="login_submit_btn">Login</button>
            </div>

            <div class="container"
                 style="min-width:100%;min-height: 36px;background-color:#deb88773; border-radius: 34px">
                <label>
                    <input style="margin-top: 2.5%" type="checkbox" name="remember"> Remember me
                </label>
                <span style="float: right;margin-right: 4%"><a href="#">Forgot password?</a></span>
            </div>
        </div>
    </div>
</section>
<asset:javascript src="/login/login.js"/>
</body>
</html>