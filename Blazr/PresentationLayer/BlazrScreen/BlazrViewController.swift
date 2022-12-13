//
//  BlazrViewController.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 08.12.2022.
//

import UIKit

class BlazrViewController: UIViewController {
    
    private let contentView = BlazrView()
    private var dataSource: [BlazrResult] = []
    private let databaseService: IDatabaseService
    
    init(database: IDatabaseService) {
        self.databaseService = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        let needAnimation = dataSource.isEmpty
        dataSource = databaseService.getResults(with: nil)
        guard !dataSource.isEmpty
        else {
            contentView.statusTitleLabel.isHidden = false
            contentView.bowlImageView.isHidden = false
            return
        }
        contentView.table.isHidden = false
        contentView.statusTitleLabel.isHidden = true
        contentView.bowlImageView.isHidden = true
        if needAnimation {
            contentView.table.reloadSections(IndexSet([0]), with: .automatic)
        } else {
            contentView.table.reloadData()
        }
    }
    
    private func setupView() {
        contentView.table.delegate = self
        contentView.table.dataSource = self
    }
}

// MARK: - TableView methods
extension BlazrViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BlazrResultListTableViewCell.reuseID) as! BlazrResultListTableViewCell
        cell.blazrResult = dataSource[safe: indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
