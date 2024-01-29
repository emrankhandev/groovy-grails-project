<%@ page import="constants.GlobalConstants" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Details</title>
    <asset:stylesheet src="dashboard/tranferlist.css"/>
</head>

<body>
<cl:isLoggedIn>
    <input type="hidden" value="${currentPage}" id="v-current-page-number"/>
    <input type="hidden" id="v-sp-transfer-search-text" value="${searchText}">

    <div style="margin: 2%">
        <cl:isAdmin>
            <span style="float: right;width:10%">
                <a id="edit-transfer-record-btn" data-ref="${transfer.id}" href="#"
                   style="color: black; margin-right: 3%">Edit</a>
                <a id="delete-transfer-record-btn" data-ref="${transfer.id}" href="#" style="color: red">Delete</a>
            </span>
        </cl:isAdmin>
        <hr/>
    </div>

    <div class="cl-container no-select-by-cursor" style="margin-left: 6%">
        <h2 style="margin-bottom: 1%"><b>Transfer Type: ${transfer.type}</b></h2>

        <div><b>Sender Name:</b> ${transfer.senderName}</div>

        <div><b>Sender Address:</b> ${transfer.senderAddress}</div>

        <div><b>Receiver Name:</b> ${transfer.receiverName}</div>

        <div><b>Receiver Address:</b> ${transfer.receiverAddress}</div>

        <div><b>Vehicle Information:</b> ${transfer.vehicleInformation}</div>

        <div style="margin-left: 2%">
            <h2 style="margin-top: 1%;margin-bottom: 1%"><b>Goods Information</b></h2>
            <g:each in="${goods}" var="item">
                <div><b>Goods Name:</b> ${item.name}</div>

                <div><b>Unit:</b> ${item.unit}</div>

                <div><b>Quantity:</b> ${item.quantity}</div>
                <hr/>
            </g:each>
        </div>
    </div>
</cl:isLoggedIn>
<script>
    $("#delete-transfer-record-btn").click(function (e) {
        let transferId = $(this).attr("data-ref");
        showLoading(e);
        $.post(contextPath + "/dashboard/deleteTransfer/", {'transferId': transferId,}, function (json) {
            if (json.success) {
                stopLoading(e);
                window.location.href = contextPath + "/dashboard/index/";
            } else {
                notifyError('Error occurred while Deleting !', 'topCenter');
            }
            stopLoading(e);
        })
    });

    $("#edit-transfer-record-btn").click(function (e) {
        let transferId = $(this).attr("data-ref");
        window.location.href = contextPath + "/dashboard/addTransfer/" + transferId;
    });
</script>
</body>
</html>