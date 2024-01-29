<%@ page import="constants.GlobalConstants" %>
<!doctype html>
<html lang="en" class="no-js">
<head>
    <link href="https://fonts.googleapis.com/css?family=Roboto|Work+Sans:400,600" rel="stylesheet">
    <asset:stylesheet src="tooltip.css"/>
    <asset:stylesheet src="shared.css"/>

    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="bootstrap_4.3.1.css"/>

    <asset:javascript src="jquery-1.10.2.js"/>
    <asset:javascript src="jquery-3.6.1.js"/>
    <asset:stylesheet src="flatpickr.css"/>
    <asset:javascript src="flatpickr.js"/>

    <asset:stylesheet src="iziToast.css"/>
    <asset:javascript src="iziToast.js"/>

    <asset:javascript src="twbsPagination.js"/>

    <asset:javascript src="bootstrap.bundle.js"/>
    <script type="text/javascript">
        contextPath = "${request.contextPath}";
    </script>

    <title>
    <g:layoutTitle default="App"/>
    </title>

    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <asset:stylesheet src="application.css"/>
    <g:layoutHead/>
</head>

<body style="height: 100vh !important;margin: 0;position: relative; background-color: azure">
<div id="spinner">
    <asset:image src="pink-spin.gif" style="margin-top: 20rem;width: 6.3rem;border-radius: 8rem"
                 alt="App"/>
</div>

<div id="popup-modal">
    <div class="row col-md-12">
        <div class="col-md-4"></div>

        <div id="popup-content" class="col-md-3 form-control">

            <div id="popup-fill-content">
            </div>

        </div>

        <div class="col-md-2"></div>
    </div>
</div>
<cl:isLoggedIn>
    <nav class="navbar navbar-expand-lg navbar-light navbar-static-top"
         style="background: linear-gradient(to right, #2f5605, #00532e, #30c268, #00140d) !important;padding: 0px !important;"
         role="navigation">
        <div class="container-fluid">
            <div class="navbar-toggler" style="z-index: 1">
                <div id="menuToggle">
                    <input type="checkbox"/>
                    <span></span>
                    <span></span>
                    <span></span>
                    <ul id="menu">
                        <li><a href="#" class="layout-home-button">Transfer List</a></li>
                        <cl:isAdmin>
                            <li><a href="#" class="layout-admin-button">Add Transfer</a></li>
                        </cl:isAdmin>
                        <li><a href="#" class="layout-logout-button">Logout</a></li>
                    </ul>
                </div>
            </div>

            <p style="text-align: center;color: white">
                <span style="font-size: 1.7rem;font-family:serif">| </span>
                <span class="layout-home-button"
                      style="cursor: pointer;font-size: 1.4rem;font-family:serif">Welcome ${session.getAttribute(GlobalConstants.USER_LOGGED_IN)}</span>
            </p>

            <div class="collapse navbar-collapse" aria-expanded="false" style="height: 3rem;" id="navbarContent">
                <ul class="nav navbar-nav ml-auto">
                    <li><a href="#" style="color: bisque" class="layout-home-button">Transfer List</a></li>
                    <cl:isAdmin>
                        <li><a href="#" style="color: bisque" class="layout-admin-button">Add Transfer</a></li>
                    </cl:isAdmin>
                    <li style="outline: white solid 1px;"><a href="#" style="color: bisque"
                                                             class="layout-logout-button">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
</cl:isLoggedIn>


<g:layoutBody>
</g:layoutBody>
<asset:javascript src="application.js"/>
<asset:javascript src="shared.js"/>

</body>
</html>