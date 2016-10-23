//
//  FriendsListViewController.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 16.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import UIKit
import SnapKit

final class FriendsListViewController: UIViewController {
  
  struct Constants {
    static let tableViewRowHeight: CGFloat = 60.0
  }
  
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
    //    reloadData()
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
    
    tableView.estimatedRowHeight = Constants.tableViewRowHeight
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  private func registerCells() {
    FriendCell.registerCell(for: tableView)
  }
  
  private func configureViewModel() {
    viewModel.addNotificationBlock { [unowned self] (deletions, insertions, modifications) in
      self.tableView.beginUpdates()
      self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) },
                                with: .automatic)
      self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) },
                                with: .automatic)
      self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) },
                                with: .automatic)
      self.tableView.endUpdates()
    }
  }
  
  //MARK: - Reload
  
  func reloadData() {
    showHUD()
    viewModel.reloadData { [weak self] (error) in
      guard let `self` = self else { return }
      self.dismissHUD()
      if let error = error {
        self.showAlert(with: error)
      }
    }
  }
  
}

//MARK: - UITableViewDelegate

extension FriendsListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    viewModel.selectFriend(at: indexPath)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = cell as? FriendCell else {
      fatalError("Cell is not FriendCell as expected")
    }
    
    cell.uniqueIndexPath = indexPath
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
