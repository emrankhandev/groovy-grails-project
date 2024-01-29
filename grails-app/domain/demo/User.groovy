package demo

import Enum.RoleType

class User {
    String email
    String firstName
    String lastName
    String password
    RoleType role

    static constraints = {
        email unique: true, nullable: false
        firstName nullable: false
        password nullable: false
        lastName nullable: true
        role nullable: false
    }

    String getFullName() {
        return lastName ? (firstName + " " + lastName) : firstName
    }
}
