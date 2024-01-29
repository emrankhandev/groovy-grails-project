package demo

import constants.GlobalConstants
import grails.converters.JSON

class DashboardController {
    def transferService

    def index() {
        final Integer maxEntriesInOnePage = GlobalConstants.MAX_ENTRY_PER_PAGE
        final Integer pageNumber = params.pageNumber ? (params.pageNumber as Integer) : 1
        final Integer offset = (pageNumber - 1) * maxEntriesInOnePage
        final String searchText = params.searchText ?: null

        final List<Transfer> transfers = Transfer.createCriteria().list(sort: "dateCreated", order: "desc", max: maxEntriesInOnePage, offset: offset) {
            if (searchText && searchText != "") {
                or {
                    ilike("type", "%${searchText}%")
                    ilike("senderName", "%${searchText}%")
                    ilike("senderAddress", "%${searchText}%")
                    ilike("receiverName", "%${searchText}%")
                    ilike("receiverAddress", "%${searchText}%")
                    ilike("vehicleInformation", "%${searchText}%")
                }
            }
        }
        final Integer totalTransfers = Transfer.count()
        final Integer totalPages = (Integer) ((totalTransfers % maxEntriesInOnePage == 0) ? totalTransfers / maxEntriesInOnePage : ((totalTransfers / maxEntriesInOnePage) + 1))

        if (totalTransfers == 0) {
            [transfers: [], currentPage: 1, totalPages: 1, totalElements: 0, searchText: searchText]
        } else {
            [transfers: transfers, currentPage: pageNumber, totalPages: totalPages, totalElements: totalTransfers, searchText: searchText]
        }
    }

    def getFilteredList() {
        final Integer maxEntriesInOnePage = GlobalConstants.MAX_ENTRY_PER_PAGE
        Integer pageNumber = params.pageNumber ? (params.pageNumber as Integer) : 1
        final String searchText = params.searchText ?: null

        final List<Transfer> totalTransfers = Transfer.createCriteria().list() {
            if (searchText && searchText != "") {
                or {
                    ilike("type", "%${searchText}%")
                    ilike("senderName", "%${searchText}%")
                    ilike("senderAddress", "%${searchText}%")
                    ilike("receiverName", "%${searchText}%")
                    ilike("receiverAddress", "%${searchText}%")
                    ilike("vehicleInformation", "%${searchText}%")
                }
            }
        }

        final Integer totalTransfersCount = (totalTransfers && totalTransfers.size() > 0) ? totalTransfers.size() : 0

        if (totalTransfersCount == 0) {
            render template: "/dashboard/list", model: [transfers: [], currentPage: 1, totalPages: 1, totalElements: 0, searchText: searchText]
        } else {
            final Integer totalPages = (Integer) ((totalTransfersCount % maxEntriesInOnePage == 0) ? totalTransfersCount / maxEntriesInOnePage : ((totalTransfersCount / maxEntriesInOnePage) + 1))

            // to remain on same page if when we delete some Entry from that
            if (pageNumber != 1 && pageNumber > totalPages) {
                pageNumber = totalPages
            }
            final Integer offset = (pageNumber - 1) * maxEntriesInOnePage

            final List<Transfer> transfers = Transfer.createCriteria().list(sort: "dateCreated", order: "desc", max: maxEntriesInOnePage, offset: offset) {
                if (searchText && searchText != "") {
                    or {
                        ilike("type", "%${searchText}%")
                        ilike("senderName", "%${searchText}%")
                        ilike("senderAddress", "%${searchText}%")
                        ilike("receiverName", "%${searchText}%")
                        ilike("receiverAddress", "%${searchText}%")
                        ilike("vehicleInformation", "%${searchText}%")
                    }
                }
            }

            render template: "/dashboard/list", model: [transfers: transfers, currentPage: pageNumber, totalPages: totalPages, totalElements: totalTransfersCount, searchText: searchText]
        }
    }

    def viewDetails(String id) {
        final Transfer transfer = Transfer.get(id.toLong())

        [transfer: transfer, goods: transfer.goods]
    }

    def deleteTransfer() {
        final Transfer transfer = Transfer.get(params.transferId.toLong())
        final Boolean result = transferService.deleteTransfer(transfer)

        render([success: result] as JSON)
    }

    def addTransfer(String id) {
        final Transfer transfer = (id && id != "") ? Transfer.get(id.toLong()) : null
        final Integer totalInputs = params.totalInputs ? params.totalInputs as Integer : (transfer ? transfer.goods.size() : 1)

        [transfer: transfer, totalInputCounts: totalInputs, goods: transfer ? transfer.goods : [], totalGoodsCount: transfer ? transfer.goods.size() : 1]
    }

    def addGoodsInput() {
        final Integer goodCount = (params.goodCount as Integer)

        render template: "/dashboard/goods", model: [goods: null, goodCount: goodCount]
    }

    def saveTransfer() {
        final Integer totalInputs = params.totalInputs as Integer
        final Long transferId = (params.transferId && params.transferId != "") ? params.transferId.toLong() : null
        final List<Goods> goods = params.goods ? JSON.parse(params.goods) as List<Goods> : []
        final String senderName = params.senderName
        final String senderAddress = params.senderAddress
        final String receiverName = params.receiverName
        final String receiverAddress = params.receiverAddress
        final String vehicleInfo = params.vehicleInfo
        final String type = params.type

        Transfer transfer = transferService.saveTransfer(transferId, totalInputs, goods, senderName, senderAddress, receiverName, receiverAddress, vehicleInfo, type)

        render([success: transfer ? true : false, model: [transferId: transfer.id]] as JSON)
    }

}
