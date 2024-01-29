package demo

class BootStrap {
    def authService

    def init = { servletContext ->
        authService.createFirstUser()
        authService.populateInitialViewData()
    }
    def destroy = {}
}
