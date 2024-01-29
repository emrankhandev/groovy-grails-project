package demo.interceptor

import constants.GlobalConstants


class AuthInterceptor {
    def authService

    AuthInterceptor() {
        matchAll()
    }

    boolean before() {
        if (params.controller == "auth") {
            return true
        }

        if (params.controller == "admin" && !session.getAttribute(GlobalConstants.IS_ADMIN)) {
            authService.endSession(session)
            redirect controller: 'auth', action: 'login'
            log.error("===========>>>>> Interceptor in Action : ${params}")
            log.error("===========>>>>> ACCESS REVOKED !!!!!! ")
            return false
        }

        if (!session.getAttribute(GlobalConstants.USER_LOGGED_IN)) {
            authService.endSession(session)
            redirect controller: 'auth', action: 'login'
            log.error("===========>>>>> Interceptor in Action : ${params}")
            log.error("===========>>>>> ACCESS REVOKED !!!!!! ")
            return false
        } else {
            return true
        }
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
