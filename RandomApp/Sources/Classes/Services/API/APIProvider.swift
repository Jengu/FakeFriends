//
//  APIProvider.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
//

import Foundation

final class APIProvider: API {
  
  //MARK: - Properties
  
  let network: Network
  
  //MARK: - Init
  
  init(network: Network) {
    self.network = network
  }
  
  //MARK: - API
  
  func getRandomFriends(success: (([Friend]) -> Void)?,
                        failure: ((Error) -> Void)?) {
    let friendRequest = RequestFactory.randomFriendsRequest()
    network.make(request: friendRequest, success: {
      (jsonDict: [String : AnyObject]) in
      
      guard var items = jsonDict["results"] as? [[String : Any]] else {
        failure?(APIError.invalidResponse)
        return
      }
      
      items = items.map() { friendDict in
        var mutableFriendDict = friendDict
        guard var idDict = friendDict["id"] as? [String : Any] else {
          fatalError()
        }
        idDict["value"] = Int(arc4random())
        mutableFriendDict["id"] = idDict
        return mutableFriendDict
      }
      
      let friends = items.flatMap() {
        Friend(JSON: $0)
      }
      
      success?(friends)
      }, failure: failure)
  }
  
}
