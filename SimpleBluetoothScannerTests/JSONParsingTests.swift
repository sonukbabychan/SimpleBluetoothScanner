import XCTest
@testable import SimpleBluetoothScanner

final class JSONParsingTests: XCTestCase {

    func testJSONDecodingSucceeds() {
        // Load JSON from bundle
        let bundle = Bundle(for: JSONParsingTests.self)
        guard let url = bundle.url(forResource: "simulated_ble", withExtension: "json") else {
            XCTFail("JSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(BLEAdvertisementResponse.self, from: data)

            // Assert
            XCTAssertFalse(decoded.advertisements.isEmpty)
            XCTAssertEqual(decoded.advertisements.count, 4)
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
