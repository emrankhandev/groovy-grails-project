package demo

import grails.gorm.transactions.Transactional

@Transactional
class TransferService {

    Boolean deleteTransfer(Transfer transfer) {
        Boolean isDeleted = false
        if (!Transfer) {
            return false
        }
        try {
            transfer.delete()
            isDeleted = true
        } catch (Exception e) {
            log.error("Error occurred while deleting Transfer !")
            log.error(e.message)
        }

        return isDeleted
    }

    Transfer saveTransfer(Long transferId, Integer totalInputs, List<Goods> goods, String senderName, String senderAddress, String receiverName, String receiverAddress, String vehicleInfo, String type) {
        Transfer transfer = null

        try {
            if (transferId) {
                transfer = Transfer.get(transferId)
                final List<Goods> foundGoods = Goods.findAllByTransfer(transfer)

                foundGoods.each {
                    transfer.removeFromGoods(it)
                }
            } else {
                transfer = new Transfer()
            }

            transfer.type = type
            transfer.senderName = senderName
            transfer.senderAddress = senderAddress
            transfer.receiverName = receiverName
            transfer.receiverAddress = receiverAddress
            transfer.vehicleInformation = vehicleInfo

            goods.each {
                transfer.addToGoods(it)
            }

            transfer.save()
        } catch (Exception e) {
            transfer = null
            log.error("Error Adding Or Updating Transfer !!")
            log.error(e.message)
        }

        return transfer
    }
}
