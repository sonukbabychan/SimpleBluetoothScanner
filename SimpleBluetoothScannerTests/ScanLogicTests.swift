import XCTest
@testable import SimpleBluetoothScanner

final class ScanLogicTests: XCTestCase {

    func testScanDoesNotCreateDuplicates() {
        let viewModel = ScanViewModel()
        viewModel.loadJSON()

        viewModel.startScan()

        // Simulate multiple reveals
        for _ in 0..<10 {
            viewModel.startScan()
        }

        let uniqueDevices = Set(viewModel.discoveredDevices.map { $0.id })

        XCTAssertEqual(
            uniqueDevices.count,
            viewModel.discoveredDevices.count,
            "Duplicate devices found in scan"
        )
    }
}
