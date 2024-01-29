function sanitizeHTML(str) {
    const temp = document.createElement('span');
    temp.textContent = str;
    return temp.innerHTML;
}

function escapeHtml(text) {
    'use strict';
    return text.replace(/[\"&<>]/g, function (a) {
        return {'"': 'quote', '&': 'amp', '<': 'gt', '>': 'ls'}[a];
    });
}

function notifyError(errorMessage, position) {
    errorMessage = escapeHtml(errorMessage);
    iziToast.error({
        title: 'Error', message: errorMessage, position: position
    });
}

function notifySuccess(errorMessage, position) {
    errorMessage = escapeHtml(errorMessage);
    iziToast.success({
        title: 'Success', message: errorMessage, position: position
    });
}

function notifyWarning(errorMessage, position) {
    errorMessage = escapeHtml(errorMessage);
    iziToast.warning({
        title: 'Warning', message: errorMessage, position: position
    });
}

$(".layout-logout-button").click(function () {
    window.location = contextPath + "/auth/logout/";
});
$(".layout-home-button").click(function () {
    window.location = contextPath + "/dashboard/index/";
});
$(".layout-admin-button").click(function () {
    window.location = contextPath + "/dashboard/addTransfer/";
});

function showLoading(e) {
    e.preventDefault();
    $("#spinner").show();
}

function stopLoading(e) {
    e.preventDefault();
    $("#spinner").hide();
}

function showPopup(e) {
    e.preventDefault();
    $("#popup-modal").fadeIn();
}

function closePopup(e) {
    e.preventDefault();
    $("#popup-modal").fadeOut();
}
