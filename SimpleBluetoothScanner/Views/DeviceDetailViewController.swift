import UIKit

final class DeviceDetailViewController: UIViewController {

    var device: BLEAdvertisement!

    // MARK: - UI Components

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()

    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private let aboutBluetoothLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.text =
        "Bluetooth allow wireless communication between nearby devices using short-range frequency."
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }

    // MARK: - UI & layouting

    private func setupUI() {
        view.backgroundColor = .white
        title = "Device Details"

        view.addSubview(nameLabel)
        view.addSubview(detailsLabel)
        view.addSubview(aboutBluetoothLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutBluetoothLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            detailsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            detailsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            aboutBluetoothLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 20),
            aboutBluetoothLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            aboutBluetoothLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }

    // MARK: - Populate Data

    private func populateData() {
        nameLabel.text = device.name

        detailsLabel.text =
        """
        RSSI: \(device.rssi)
        Battery Level: \(device.battery)%
        Device Type: \(device.type)
        Bluetooth Profile: \(device.profile)
        """
    }
}
