import UIKit

final class DeviceTableViewCell: UITableViewCell {

    static let identifier = "DeviceTableViewCell"

    // MARK: - UI Components

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()

    private let rssiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let batteryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let profileLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()

    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup & layouting

    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(rssiLabel)
        contentView.addSubview(batteryLabel)
        contentView.addSubview(profileLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        rssiLabel.translatesAutoresizingMaskIntoConstraints = false
        batteryLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            rssiLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            rssiLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            batteryLabel.centerYAnchor.constraint(equalTo: rssiLabel.centerYAnchor),
            batteryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            profileLabel.topAnchor.constraint(equalTo: rssiLabel.bottomAnchor, constant: 6),
            profileLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            profileLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    // MARK: - Configuration

    func configure(with device: BLEAdvertisement) {
        nameLabel.text = device.name
        rssiLabel.text = "RSSI: \(device.rssi)"
        batteryLabel.text = "Battery: \(device.battery)%"
        profileLabel.text = "Profile: \(device.profile)"
    }
}
