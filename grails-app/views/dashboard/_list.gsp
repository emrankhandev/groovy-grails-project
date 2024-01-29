<%@ page import="constants.GlobalConstants" %>
<cl:isLoggedIn>
    <div class="cl-container no-select-by-cursor">
        <input type="hidden" value="${currentPage}" id="current-page-number"/>
        <input type="hidden" value="${totalPages}" id="last-page-number"/>
        <input type="hidden" id="sp-transfer-search-text" value="${searchText}">

        <div>
            <input value="${searchText}" id="transfer-search-text-value" type="search"
                   placeholder="Search by Type or Any field..."
                   style=" width: 89%; margin-top: 2%; margin-bottom: 1%; margin-left: 4px; border-radius: 8px;"/>
            <button id="search-transfer-btn"
                    style="color: white; width: 9%; border-radius: 6px; background-color: forestgreen; border-color: antiquewhite;"><b>Search</b>
            </button>
        </div>

        <div class="table-responsive table-borderless" id="school-list-table-div"
             style="min-height: 27.5vh;max-height: 71.7vh;border-radius: 0.7rem 1.1rem 1rem 0.7rem;border-bottom: solid; max-width: 99%; margin-left: 5px">
            <table class="table" style="margin-top: 0;margin-bottom: 0">
                <tr><th>Type</th>
                    <th>Sender Name</th>
                    <th>Sender Address</th>
                    <th>Receiver Name</th>
                    <th>Receiver Address</th>
                    <th>Vehicle Information</th>
                    <th>Action</th>
                </tr>
                <g:if test="${transfers.size() == 0}">
                    <tr><td></td><td></td><td></td><td>No Data Available</td><td></td><td></td><td></td>
                    </tr>
                </g:if>
                <g:each in="${transfers}" var="order">
                    <tr>
                        <td>${order.type}</td>
                        <td>${order.senderName}</td>
                        <td>${order.senderAddress}</td>
                        <td>${order.receiverName}</td>
                        <td>${order.receiverAddress}</td>
                        <td>${order.vehicleInformation}</td>
                        <g:if test="${session.getAttribute(GlobalConstants.IS_ADMIN)}">
                            <td><a class="edit-view-transfer-link" data-ref="${order.id}" href="#"
                                   style="color: black">Edit View</a>
                                <a class="admin-delete-transfer-link" data-ref="${order.id}" href="#"
                                   style="color: black">Delete</a>
                            </td>
                        </g:if>
                        <g:else>
                            <td><a class="edit-view-transfer-link" data-ref="${order.id}" href="#"
                                   style="color: black">View</a></td>
                        </g:else>
                    </tr>
                </g:each>
                <tr class="end-row">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>

            <div class="text-center">
                <g:if test="${totalElements > 0}">
                    <ul style="display: inline-flex" id="transfer-list-pagination" class="pagination-sm"></ul>
                </g:if>

                <div class="text-center">
                    <span class="text-danger font-monospace">Total Transfers : ${totalElements}</span>
                </div>
            </div>
        </div>
    </div>
</cl:isLoggedIn>
<script>
    function callPaginate(event, page) {
        let searchTexts = $("#sp-transfer-search-text").val()
        if (page !== ${currentPage}) {
            showLoading(event);
            $("#sp-create-show-data-list").load(contextPath + "/dashboard/getFilteredList/", {
                'searchText': searchTexts,
                'pageNumber': page,
            }, function () {
                stopLoading(event);
            });
        }
    }

    $('#transfer-list-pagination').twbsPagination({
        startPage: ${currentPage},
        totalPages: ${totalPages},
        visiblePages: 5,
        next: 'Next',
        prev: 'Prev',
        onPageClick: function (event, page) {
            if (page !== ${currentPage}) {
                callPaginate(event, page);
            }
        }
    });

    $("#search-transfer-btn").click(function (event) {
        let searchTextValue = $("#transfer-search-text-value").val()
        if (searchTextValue !== "" && searchTextValue !== undefined && searchTextValue.length > 3) {
            showLoading(event);
            $("#sp-create-show-data-list").load(contextPath + "/dashboard/getFilteredList/", {
                'searchText': searchTextValue,
                'pageNumber': 1,
            }, function () {
                stopLoading(event);
            });
        } else if (searchTextValue === "") {
            showLoading(event);
            $("#sp-create-show-data-list").load(contextPath + "/dashboard/getFilteredList/", {
                'searchText': "",
                'pageNumber': 1,
            }, function () {
                stopLoading(event);
            });
        } else {
            notifyError("Search text must be at least 3 characters long", "topCenter");
        }
    });

    $(".admin-delete-transfer-link").click(function (e) {
        let transferId = $(this).attr("data-ref");
        showLoading(e);
        $.post(contextPath + "/dashboard/deleteTransfer/", {'transferId': transferId,}, function (json) {
            if (json.success) {
                refresh("Deleted Successfully !");
            } else {
                notifyError('Error occurred while Deleting !', 'topCenter');
            }
            stopLoading(e);
        })
    });

    function refresh(message) {
        let searchTexts = $("#sp-transfer-search-text").val()
        let currentPage = $("#current-page-number").val()

        //showLoading(event);
        $("#sp-create-show-data-list").load(contextPath + "/dashboard/getFilteredList/", {
            'searchText': searchTexts,
            'pageNumber': currentPage,
        }, function () {
            //stopLoading(event);
            notifySuccess(message, 'topCenter');
        });
    }

    $(".edit-view-transfer-link").click(function (e) {
        e.preventDefault();
        let transferId = $(this).attr("data-ref");

        window.location.href = contextPath + "/dashboard/viewDetails/" + transferId;
    });

</script>