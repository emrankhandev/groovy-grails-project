package demo

import constants.GlobalConstants
import grails.converters.JSON
import grails.web.Controller

import javax.servlet.http.HttpSession

@Controller
class AuthController {
    def authService

    def login() {
        render view: '/auth/login'
    }

    def authenticate() {
        final String email = params.username
        final String password = params.password
        final User user = User.findByEmailAndPassword(email, password)

        if (user) {
            final HttpSession session = request.getSession()
            authService.createSessionForUser(session, user)

            render([success: true, model: [loggedInId: true]] as JSON)
            return false
        } else {
            render([success: false, model: [message: "User not found, Email or Password is Wrong!"]] as JSON)
            return false
        }
    }

    def logout() {
        if (session.getAttribute(GlobalConstants.USER_LOGGED_IN)) {
            authService.endSession(session)
        }

        redirect action: "login"
        return false
    }

}
