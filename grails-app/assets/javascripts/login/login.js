function callLogin() {
    let username = $("#login_input").val();
    let password = $("#login_pass").val();

    if (!username || username === "" || !username.includes('.com')) {
        iziToast.error({
            title: 'Error', message: "Please enter valid Email", position: 'topCenter'
        });
        return false;
    } else if (!password || password === "") {
        iziToast.error({
            title: 'Error', message: "Please enter Password", position: 'topCenter'
        });
        return false;
    } else {
        $.ajax({
            type: "POST",
            data: {username: username, password: password},
            url: contextPath + "/auth/authenticate/",
            success: function (jsonResp) {
                if (jsonResp.success) {
                    window.location = contextPath + "/dashboard/index/";
                } else {
                    iziToast.error({
                        title: 'Error', message: jsonResp.model.message, position: 'topCenter'
                    });
                }
            }
        });
    }
}

$("#login_submit_btn").click(function () {
    callLogin();
});

$("#login_pass").keypress(function (event) {
    const keycode = (event.keyCode ? event.keyCode : event.which);
    if (keycode == '13') {
        callLogin();
    }
});

$("#login_input").keypress(function (event) {
    const keycode = (event.keyCode ? event.keyCode : event.which);
    if (keycode == '13') {
        callLogin();
    }
});