//
//  FriendsListViewController.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 16.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import UIKit
import SnapKit

final class FriendsListViewController: UIViewController {
  
  //MARK: - Properties

  fileprivate var viewModel: FriendsListViewModel!
  lazy private var tableView = UITableView()
  
  //MARK: - Init
  
  init(viewModel: FriendsListViewModel) {
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
    reloadData()
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
    
    tableView.estimatedRowHeight = 60
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  private func registerCells() {
    FriendCell.registerCell(for: tableView)
  }
  
  private func configureViewModel() {
    viewModel.willUpdate = { [weak self] in
      self?.viewModelWillUpdate()
    }
    
    viewModel.didUpdate = { [weak self] in
      self?.viewModelDidUpdate()
    }
    
    viewModel.didFail = { [weak self] (error) in
      self?.viewModelDidFail(error: error)
    }
  }
  
  //MARK: - Reload
  
  private func reloadData() {
    viewModel.reloadData()
  }
  
  //MARK: - Update
  
  private func viewModelWillUpdate() {
    
  }
  
  private func viewModelDidUpdate() {
    tableView.reloadData()
  }
  
  private func viewModelDidFail(error: Error) {
    
  }
  
}

//MARK: - UITableViewDelegate

extension FriendsListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? FriendCell else {
      fatalError("Cell is not FriendCell as expected")
    }
    
    let cellViewModel = viewModel.cellViewModel(for: indexPath)
    cell.update(with: cellViewModel)
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
