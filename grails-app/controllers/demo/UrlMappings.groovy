package demo

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?" {
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "auth", action: 'login')
        "/logout"(controller: "auth", action: 'logout')
        "500"(view: '/error')
        "404"(view: '/notFound')
    }
}
