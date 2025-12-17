import Foundation

struct BLEAdvertisementResponse: Codable {
    let advertisements: [BLEAdvertisement]
}

struct BLEAdvertisement: Codable, Equatable {
    let id: String
    let name: String
    let rssi: Int
    let battery: Int
    let type: String
    let profile: String
    let advertisingData: AdvertisingData
}

struct AdvertisingData: Codable {
    let serviceUUIDs: [String]
    let manufacturerData: String?
    let txPowerLevel: Int?
}
