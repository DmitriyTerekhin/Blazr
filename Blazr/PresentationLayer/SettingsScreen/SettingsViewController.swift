//
//  SettingsViewController.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let presenter: ISettingsPresenter
    private let contentView = SettingsView()
    private var settingsDataSource: [SettingType] = []
    private let presentationAssembly: IPresentationAssembly
    
    init(presenter: ISettingsPresenter, presentationAssembly: IPresentationAssembly) {
        self.presenter = presenter
        self.presentationAssembly = presentationAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        settingsDataSource = presenter.getDataSource()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
}

// MARK: - TableView methods
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = settingsDataSource[safe: indexPath.row] else { return }
        presenter.settingWasTapped(type: type)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseID) as! SettingsTableViewCell
        cell.titleLabel.text = settingsDataSource[safe: indexPath.row]?.title ?? ""
        cell.selectionStyle = .none
        return cell
    }
}
