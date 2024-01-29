package demo

class Goods {
    String name
    String unit
    Integer quantity = 1

    // only used for default sorting, so we see latest Good at bottom
    Date dateCreated = new Date()

    static belongsTo = [transfer: Transfer]

    static constraints = {
        name nullable: false
        unit nullable: false
        quantity nullable: false
    }
}
