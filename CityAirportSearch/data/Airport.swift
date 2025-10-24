//
//  Airport.swift
//  CityAirportSearch
//
//  Created by Azizbek Asadov on 23.10.2025.
//

import CoreLocation

typealias LocationCoordinates = CLLocationCoordinate2D

struct Airport: Identifiable, Codable, Sendable {
    let id: UUID
    let code: String
    let coordinates: LocationCoordinates
    let name: String
    let city: String
    let country: String
    let woeid: String
    let tz: String
    let phone: String
    let type: String
    let email: String
    let url: String
    let runWayLength: String?
    let elev: String?
    let icao: String
    let directFlights: String
    let carriers: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case lat
        case lon
        case name
        case city
        case country
        case woeid
        case tz
        case phone
        case type
        case email
        case url
        case runWayLength = "runway_length"
        case elev
        case icao
        case directFlights = "direct_flights"
        case carriers
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.code, forKey: .code)
        try container.encode(self.city, forKey: .city)
        try container.encode(self.coordinates.latitude, forKey: .lat)
        try container.encode(self.coordinates.longitude, forKey: .lon)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.woeid, forKey: .woeid)
        try container.encode(self.tz, forKey: .tz)
        try container.encode(self.phone, forKey: .phone)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.runWayLength, forKey: .runWayLength)
        try container.encode(self.elev, forKey: .elev)
        try container.encode(self.icao, forKey: .icao)
        try container.encode(self.directFlights, forKey: .directFlights)
        try container.encode(self.carriers, forKey: .carriers)
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.code = try container.decode(String.self, forKey: .code)
        self.city = try container.decode(String.self, forKey: .city)
        self.coordinates = CLLocationCoordinate2D(
            latitude: Double(try container.decode(String.self, forKey: .lat)) ?? 0.0,
            longitude: Double(try container.decode(String.self, forKey: .lon)) ?? 0.0
        )
        self.country = try container.decode(String.self, forKey: .country)
        self.woeid = try container.decode(String.self, forKey: .woeid)
        self.tz = try container.decode(String.self, forKey: .tz)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.type = try container.decode(String.self, forKey: .type)
        self.email = try container.decode(String.self, forKey: .email)
        self.url = try container.decode(String.self, forKey: .url)
        self.runWayLength = try container.decode(Optional<String>.self, forKey: .runWayLength)
        self.elev = try container.decode(Optional<String>.self, forKey: .elev)
        self.icao = try container.decode(String.self, forKey: .icao)
        self.directFlights = try container.decode(String.self, forKey: .directFlights)
        self.carriers = try container.decode(String.self, forKey: .carriers)
    }
}

extension Airport: Equatable {
    static func == (lhs: Airport, rhs: Airport) -> Bool {
        lhs.code == rhs.code
    }
}

extension Airport: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.code)
    }
}
