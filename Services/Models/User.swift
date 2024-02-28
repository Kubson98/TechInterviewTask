//
//  User.swift
//  Services
//
//  Created by Jakub Sędal on 26/02/2024.
//

public struct User: Decodable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String
    public let address: Address
    public let phone: String
    public let website: String
    public let company: Company
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(Address.self, forKey: .address)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.website = try container.decode(String.self, forKey: .website)
        self.company = try container.decode(Company.self, forKey: .company)
    }
    
    init(
        id: Int,
        name: String,
        username: String,
        email: String,
        address: Address,
        phone: String,
        website: String,
        company: Company
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
}

public struct Company: Decodable {
    public let name: String
    public let catchPhrase: String
    public let bs: String
    
    enum CodingKeys: CodingKey {
        case name
        case catchPhrase
        case bs
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.catchPhrase = try container.decode(String.self, forKey: .catchPhrase)
        self.bs = try container.decode(String.self, forKey: .bs)
    }
    
    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}

public struct Address: Decodable {
    public let street: String
    public let suite: String
    public let city: String
    public let zipcode: String
    public let geo: Geo
    
    enum CodingKeys: CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(String.self, forKey: .street)
        self.suite = try container.decode(String.self, forKey: .suite)
        self.city = try container.decode(String.self, forKey: .city)
        self.zipcode = try container.decode(String.self, forKey: .zipcode)
        self.geo = try container.decode(Geo.self, forKey: .geo)
    }
    
    init(street: String, suite: String, city: String, zipcode: String, geo: Geo) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
}

extension Address {
    public var presentableAddress: String {
        return String("\(self.street), \(self.suite), \(self.city) \(self.zipcode)")
    }
}

public struct Geo: Decodable {
    public let lat: String
    public let lng: String
    
    enum CodingKeys: CodingKey {
        case lat
        case lng
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.lng = try container.decode(String.self, forKey: .lng)
    }
    
    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
}
