<%--
  Created by IntelliJ IDEA.
  User: sayto
  Date: 27-01-2024
  Time: 01:31 am
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Form</title>
    <asset:stylesheet src="dashboard/tranferlist.css"/>
</head>

<body>
<cl:isLoggedIn>
    <cl:isAdmin>
        <div style="border-radius: 7%;margin-bottom:1%;background-color: #adb5bd75;padding-bottom: 1px; text-align: center;max-width: 85%;margin-left: 8%">
            <input type="hidden" id="total-input-counts" value="${totalInputCounts}">
            <input type="hidden" id="editing-transfer-id" value="${transfer?.id}">

            <h1 style="margin-bottom: 2%;font-size: revert"><b>Transfer Form</b></h1>

            <div style="margin-bottom:2% !important;margin: 5%;text-align: left;background-color: azure;border-radius: 5px;padding-left: 2%; padding-top: 1%; padding-bottom: 1%">

                <div>
                    <h2>Type:</h2>
                </div>

                <div class="form-check form-check-inline" style="width: 100%">
                    <g:select
                            style="min-width: 13.9rem;border-radius: 0.3rem; width: 96%; min-height: 5vh; background-color: #d3d3d366"
                            data-ref="${transfer?.id}"
                            id="transfer-type-input"
                            name='transfer-type-input'
                            from="${['Internal', 'External']}"
                            value="${transfer?.type}"/>
                    <br>
                </div>

                <div>
                    <h2>Sender Name<span class="astrik"></span>:</h2>
                </div>

                <div class="form-check form-check-inline" style="width: 100%">
                    <input name="sender-name-input" id="sender-name-input"
                           style="min-width: 13.9rem;border-radius: 0.3rem; width: 96%"
                           placeholder="Enter Sender's Name" value="${transfer?.senderName}"/>
                    <br>
                </div>

                <div>
                    <h2>Sender Address<span class="astrik"></span>:</h2>
                </div>

                <div class="form-check form-check-inline" style="width: 100%">
                    <g:textArea type="text" name="sender-address-input" id="sender-address-input"
                                style="height: 79%;min-width: 13.9rem;border-radius: 0.3rem; width: 96%"
                                placeholder="Enter Sender's Address" value="${transfer?.senderAddress}"/>
                    <br>
                </div>

                <div>
                    <h2>Receiver Name<span class="astrik"></span>:</h2>
                </div>

                <div class="form-check form-check-inline" style="width: 100%">
                    <input name="receiver-name-input" id="receiver-name-input"
                           style="min-width: 13.9rem;border-radius: 0.3rem; width: 96%"
                           placeholder="Enter Receiver's Name" value="${transfer?.receiverName}"/>
                    <br>
                </div>

                <div>
                    <h2>Receiver Address<span class="astrik"></span>:</h2>
                </div>

                <div class="form-check form-check-inline" style="width: 100%">
                    <g:textArea type="text" name="receiver-address-input" id="receiver-address-input"
                                style="height: 79%;min-width: 13.9rem;border-radius: 0.3rem; width: 96%"
                                placeholder="Enter Receiver's Address" value="${transfer?.receiverAddress}"/>
                    <br>
                </div>

                <div>
                    <h2>Vehicle Information<span class="astrik"></span>:</h2>
                </div>

                <div class="form-check form-check-inline" style="width: 100%">
                    <input name="vehicle-information-input" id="vehicle-information-input"
                           style="min-width: 13.9rem;border-radius: 0.3rem; width: 96%"
                           placeholder="Enter Receiver's Name" value="${transfer?.vehicleInformation}"/>
                    <br>
                    <br>
                </div>

                <h2><b>Goods Information</b></h2>

                <table id="goods-inputs-area" class="table" style="margin-top: 0;margin-bottom: 0; max-width: 96%">
                    <tr><th>Name</th>
                        <th>Unit</th>
                        <th>Quantity</th>
                    </tr>
                    <g:each in="${(0..<totalInputCounts)}" var="number">
                        <g:if test="${number > totalGoodsCount}">
                            <g:render template="goods" model="[goodCount: number, goods: null]"/>
                        </g:if>
                        <g:else>
                            <g:render template="goods" model="[goodCount: number, goods: goods[number]]"/>
                        </g:else>
                    </g:each>
                </table>
            </div>

            <div style="text-align: left">
                <span><input id="save-edit-transfer-btn" data-ref="${transfer?.id}"
                             data-total-inputs="${totalInputCounts}"
                             style="margin-bottom: 1%;margin-left: 7%;width: 15%;background-color: #5b5f63; color: white;border-radius: 7px"
                             type="button"
                             value="Submit"></span>

                <span><input id="add-goods-btn" data-ref="${transfer?.id}" data-total-inputs="${totalInputCounts}"
                             style="margin-left: 54% !important;margin-bottom: 1%;width: 15%;background-color: forestgreen; color: white;border-radius: 7px"
                             type="button"
                             value="Add Goods"></span>
            </div>
        </div>
    </cl:isAdmin>
    <script>
        $("#add-goods-btn").click(function (event) {
            event.preventDefault();
            let totalInputs = $("#total-input-counts").val();

            $.post(contextPath + "/dashboard/addGoodsInput/", {'goodCount': totalInputs,}, function (html) {
                if (undefined != html && null != html) {
                    $("#goods-inputs-area").append(html);
                    $("#total-input-counts").val(parseInt(totalInputs) + 1);
                } else {
                    notifyError('Error occurred while Adding Goods !', 'topCenter');
                }
                stopLoading(event);
            })
        });

        $("#save-edit-transfer-btn").click(function (event) {
            event.preventDefault();
            let totalInputs = parseInt($("#total-input-counts").val());
            let transferId = $("#editing-transfer-id").val();

            let senderName = $("#sender-name-input").val();
            let senderAddress = $("#sender-address-input").val();
            let receiverName = $("#receiver-name-input").val();
            let receiverAddress = $("#receiver-address-input").val();
            let vehicleInfo = $("#vehicle-information-input").val();
            let type = $("#transfer-type-input").val();
            let goods = [];

            if (!senderName || senderName === "") {
                notifyError('Please enter Sender Name', 'topCenter');
                return false;
            } else if (!senderAddress || senderAddress === "") {
                notifyError('Please enter Sender Address', 'topCenter');
                return false;
            } else if (!receiverName || receiverName === "") {
                notifyError('Please enter Receiver Name', 'topCenter');
                return false;
            } else if (!receiverAddress || receiverAddress === "") {
                notifyError('Please enter Receiver Address', 'topCenter');
                return false;
            } else if (!vehicleInfo || vehicleInfo === "") {
                notifyError('Please enter Vehicle Information', 'topCenter');
                return false;
            } else {
                for (let i = 0; i < totalInputs; i++) {
                    let goodsName = $(("#good-name-input_" + i)).val();
                    let goodsQuantity = $("#good-quantity-input_" + i).val();
                    let goodsUnit = $("#good-unit-input_" + i).val();

                    if (!goodsName || goodsName === "") {
                        notifyError('Please enter valid Name of Goods', 'topCenter');
                        return false;
                    } else if (!goodsQuantity || goodsQuantity === "" || goodsQuantity.includes("e") || goodsQuantity.includes(".")) {
                        notifyError('Please enter valid Quantity of Goods', 'topCenter');
                        return false;
                    }

                    goods.push({name: goodsName, unit: goodsUnit, quantity: goodsQuantity})
                }
            }

            $("#save-edit-transfer-btn").hide();
            $("#add-goods-btn").hide();

            $.post(contextPath + "/dashboard/saveTransfer/", {
                'totalInputs': totalInputs,
                'transferId': transferId,
                'goods': JSON.stringify(goods),
                'senderName': senderName,
                'senderAddress': senderAddress,
                'receiverName': receiverName,
                'receiverAddress': receiverAddress,
                'vehicleInfo': vehicleInfo,
                'type': type
            }, function (json) {
                if (json.success) {
                    let transferId = json.model.transferId;
                    window.location.href = contextPath + "/dashboard/viewDetails/" + transferId;
                } else {
                    notifyError('Error occurred while Saving !', 'topCenter');
                    $("#save-edit-transfer-btn").show();
                    $("#add-goods-btn").show();
                }
            })
        });
    </script>
</cl:isLoggedIn>
</body>
</html>