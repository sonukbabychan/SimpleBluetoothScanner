import UIKit

final class ScanViewController: UIViewController {

    // MARK: - UI Components

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Scan", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()

    private let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stop Scan", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let viewModel = ScanViewModel()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
        setupTableView()
        setupBindings()
        viewModel.loadJSON()
    }

    // MARK: - UI & layouting

    private func setupUIComponents() {
        view.backgroundColor = .white
        title = "Bluetooth Scan"

        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(activityIndicator)
        view.addSubview(tableView)

        startButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            stopButton.topAnchor.constraint(equalTo: startButton.topAnchor),
            stopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            activityIndicator.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 12),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            tableView.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        startButton.addTarget(self, action: #selector(startScanTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopScanTapped), for: .touchUpInside)
    }

    // MARK: - TableView

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            DeviceTableViewCell.self,
            forCellReuseIdentifier: DeviceTableViewCell.identifier
        )
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }

    // MARK: - Bindings

    private func setupBindings() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.onScanStopped = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
    }

    // MARK: - Button Actions

    @objc private func startScanTapped() {
        activityIndicator.startAnimating()
        viewModel.startScan()
    }

    @objc private func stopScanTapped() {
        viewModel.stopScan()
    }
}

// MARK: - UITableViewDataSource

extension ScanViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.discoveredDevices.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DeviceTableViewCell.identifier,
            for: indexPath
        ) as? DeviceTableViewCell else {
            return UITableViewCell()
        }

        let device = viewModel.discoveredDevices[indexPath.row]
        cell.configure(with: device)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ScanViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DeviceDetailViewController()
        detailVC.device = viewModel.discoveredDevices[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
