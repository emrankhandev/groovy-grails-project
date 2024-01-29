package demo

import Enum.RoleType
import constants.GlobalConstants

class AppTagLib {
    static namespace = "cl"
    def authService

    def isLoggedIn = { attr, body ->
        if (session.getAttribute(GlobalConstants.USER_LOGGED_IN)) {
            out << body()
        }
    }

    def isAdmin = { attr, body ->
        if (session.getAttribute(GlobalConstants.IS_ADMIN)) {
            out << body()
        }
    }

}
