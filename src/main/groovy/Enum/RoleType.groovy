package Enum

enum RoleType {
    // these MUST be same if made in Uppercase e.g ADMIN.toUpperCase() = ADMIN
    ADMIN('Admin'),
    VIEWER('Viewer')

    private RoleType(String name) {
        this.name = name
    }

    private final String name

    @Override
    String toString() {
        // return like Admin
        return name
    }

    String getKey() {
        // return like ADMIN
        return name()
    }

    static List<RoleType> getAllRoleTypes() {
        return values()
    }
}