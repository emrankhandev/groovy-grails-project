<%--
  Created by IntelliJ IDEA.
  User: sayto
  Date: 24-01-2024
  Time: 05:10 pm
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <asset:stylesheet src="dashboard/tranferlist.css"/>
</head>

<body>
<div>

    <div id="sp-create-show-data-list">
        <g:render template="list"
                  model="[transfers: transfers, currentPage: currentPage, totalPages: totalPages, totalElements: totalElements, searchText: searchText]"/>
    </div>

</div>
</body>

</html>