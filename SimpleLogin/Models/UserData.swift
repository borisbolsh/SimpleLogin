import Foundation

struct UserData {
    var name: String?
    var city: String?
    var email: String?
    var phone: String?
}

extension UserData {
    static var userData = UserData(
        name: "John Doe",
        city: "Mexico",
        email: "john.hoe@mail.com",
        phone: "+1(999)888-77-66"
    )
}
