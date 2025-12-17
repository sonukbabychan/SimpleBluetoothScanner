import Foundation

final class ScanViewModel {

    private(set) var allDevices: [BLEAdvertisement] = []
    private(set) var discoveredDevices: [BLEAdvertisement] = []

    private var timer: Timer?
    private var currentIndex = 0

    var onUpdate: (() -> Void)?
    var onScanStopped: (() -> Void)?

    func loadJSON() {
        guard let url = Bundle.main.url(forResource: "simulated_ble", withExtension: "json") else {
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(BLEAdvertisementResponse.self, from: data)
            allDevices = decoded.advertisements
        } catch {
            print("JSON parsing error: \(error)")
        }
    }

    func startScan() {
        stopScan()
        discoveredDevices.removeAll()
        currentIndex = 0

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.revealNextDevice()
        }
    }

    private func revealNextDevice() {
        guard currentIndex < allDevices.count else {
            stopScan()
            return
        }

        let device = allDevices[currentIndex]

        if !discoveredDevices.contains(device) {
            discoveredDevices.append(device)
            onUpdate?()
        }

        currentIndex += 1
    }

    func stopScan() {
        timer?.invalidate()
        timer = nil
        onScanStopped?()
    }
}
