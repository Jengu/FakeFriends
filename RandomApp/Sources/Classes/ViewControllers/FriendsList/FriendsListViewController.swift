//
//  FriendsListViewController.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 16.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit
import SnapKit

final class FriendsListViewController: UIViewController, ViewModellable {
  
  //MARK: - Properties

  typealias ViewModel = FriendsListViewModel
  let viewModel: FriendsListViewModel
  
  lazy private var tableView = UITableView()
  
  //MARK: - Init
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.reloadData()
  }
  
  //MARK: - Configure
  
  private func configureView() {
    configureTableView()
    registerCells()
    
    configureViewModel()
  }
  
  private func configureTableView() {
    tableView.tableFooterView = UIView()
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func registerCells() {
    FriendCell.registerCell(for: tableView)
  }
  
  private func configureViewModel() {
    
  }
  
}

//MARK: - UITableViewDelegate

extension FriendsListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let cell = cell as? FriendCell {
      cell.textLabel?.text = "kek #\(indexPath.row)"
    }
  }
  
}

//MARK: - UITableViewDataSource

extension FriendsListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return FriendCell.dequeueCell(for: tableView, for: indexPath)
  }
  
}
