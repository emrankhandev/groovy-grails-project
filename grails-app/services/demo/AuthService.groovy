package demo

import Enum.RoleType
import constants.GlobalConstants
import grails.gorm.transactions.Transactional

import javax.servlet.http.HttpSession

@Transactional
class AuthService {

    void populateInitialViewData() {
        Transfer order1 = new Transfer(type: "Internal", senderName: "Jack", senderAddress: "5011, Juli Street, Mono, America, 258897", receiverName: "Nina", receiverAddress: "House 3665, Damp Streets, America, 27799800", vehicleInformation: "Bus with number HGY172")
        Goods item1 = new Goods(name: "Floor", unit: "KG", quantity: 15)
        Goods item2 = new Goods(name: "Oven", unit: "CFT", quantity: 1)
        Goods item3 = new Goods(name: "Pulses", unit: "KG", quantity: 11)
        order1.addToGoods(item1)
        order1.addToGoods(item2)
        order1.addToGoods(item3)
        order1.save()

        Transfer order2 = new Transfer(type: "External", senderName: "John", senderAddress: "5011, John Street, Mono, America, 258897", receiverName: "Larry", receiverAddress: "House 7665, Damp Streets, America, 27799800", vehicleInformation: "Car with number LHJIY377")
        Goods item4 = new Goods(name: "Floor", unit: "KG", quantity: 18)
        Goods item5 = new Goods(name: "Oven", unit: "CFT", quantity: 2)
        Goods item6 = new Goods(name: "Pulses", unit: "KG", quantity: 13)
        order2.addToGoods(item4)
        order2.addToGoods(item5)
        order2.addToGoods(item6)
        order2.save()

        Transfer order3 = new Transfer(type: "Internal", senderName: "Jacky", senderAddress: "5011, John Street, Mono, America, 258897", receiverName: "Dorry", receiverAddress: "House 7665, Damp Streets, America, 27799800", vehicleInformation: "Car with number LHJIY377")
        Goods item7 = new Goods(name: "Floor", unit: "KG", quantity: 18)
        Goods item8 = new Goods(name: "Oven", unit: "CFT", quantity: 2)
        Goods item9 = new Goods(name: "Pulses", unit: "KG", quantity: 13)
        order3.addToGoods(item7)
        order3.addToGoods(item8)
        order3.addToGoods(item9)
        order3.save()

        Transfer order4 = new Transfer(type: "External", senderName: "Ben", senderAddress: "5011, John Street, Mono, America, 258897", receiverName: "Steve", receiverAddress: "House 7665, Damp Streets, America, 27799800", vehicleInformation: "Car with number LHJIY377")
        Goods item10 = new Goods(name: "Floor", unit: "KG", quantity: 18)
        Goods item11 = new Goods(name: "Oven", unit: "CFT", quantity: 2)
        Goods item12 = new Goods(name: "Pulses", unit: "KG", quantity: 13)
        order4.addToGoods(item10)
        order4.addToGoods(item11)
        order4.addToGoods(item12)
        order4.save()
    }

    void createFirstUser() {
        User admin = User.findByEmail("admin@gmail.com")
        User user = User.findByEmail("user@gmail.com")

        if (!admin) {
            admin = new User(email: "admin@gmail.com", firstName: "Admin", lastName: "Person", password: "admin", role: RoleType.ADMIN)
            admin.save()
        }

        if (!user) {
            user = new User(email: "user@gmail.com", firstName: "User", lastName: "Viewer", password: "user", role: RoleType.VIEWER)
            user.save()
        }
    }

    void createSessionForUser(HttpSession session, User user) {
        session.setAttribute(GlobalConstants.USER_LOGGED_IN, user.getFullName())
        if (user.role == RoleType.ADMIN) {
            session.setAttribute(GlobalConstants.IS_ADMIN, true)
        }
    }

    void endSession(HttpSession session) {
        session.invalidate()
    }
}
