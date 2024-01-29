package demo

class Transfer {
    String type

    String senderName
    String senderAddress

    String receiverName
    String receiverAddress

    String vehicleInformation

    // only used for default sorting, so we see latest transfer at top
    Date dateCreated = new Date()

    static hasMany = [goods: Goods]

    static constraints = {
        type nullable: false
        senderName nullable: false
        senderAddress nullable: false
        receiverName nullable: false
        receiverAddress nullable: false
        vehicleInformation nullable: false
    }

    static mapping = {
        goods cascade: "all-delete-orphan", lazy: false, sort: "dateCreated"
    }
}
