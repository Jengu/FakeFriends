//
//  NetworkProvider.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 Jengu. All rights reserved.
//

import Foundation

class NetworkProvider: Network {
  
  //MARK: - Properties
  
  private let session: URLSession
  private let mainDispatchQueue = DispatchQueue.main
  
  //MARK: - Lifecycle
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  //MARK: - Make request
  
  func make(request: NetworkRequest,
            success: (([String : AnyObject]) -> Void)?,
            failure: ((Error) -> Void)?) {
    do {
      let request = try request.buildURLRequest()
      print("Request: \(request.description)")
      let task = self.session.dataTask(with: request,
                                       completionHandler: { [weak self] (data, response, error) in
                                        guard let data = data else {
                                          self?.mainDispatchQueue.async {
                                            failure?(error ?? NetworkError.unknown)
                                          }
                                          return
                                        }
                                        
                                        guard let jsonOptional = try? JSONSerialization.jsonObject(with: data, options: []),
                                          let json = jsonOptional as? [String: AnyObject] else {
                                            self?.mainDispatchQueue.async {
                                              failure?(NetworkError.invalidResponse)
                                            }
                                            return
                                        }
                                        
                                        self?.mainDispatchQueue.async {
                                          print("Response: \(json.description)")
                                          success?(json)
                                        }
      })
      
      task.resume()
      
    } catch let error {
      mainDispatchQueue.async {
        failure?(error)
      }
    }
  }
  
  func make(request: NetworkRequest,
            success: ((Data) -> Void)?,
            failure: ((Error) -> Void)?) {
    do {
      let request = try request.buildURLRequest()
      let task = self.session.dataTask(with: request,
                                       completionHandler: { [weak self] (data, response, error) in
                                        guard let data = data else {
                                          self?.mainDispatchQueue.async {
                                            failure?(error ?? NetworkError.unknown)
                                          }
                                          return
                                        }
                                        
                                        self?.mainDispatchQueue.async {
                                          success?(data)
                                        }
      })
      
      task.resume()
      
    } catch let error {
      mainDispatchQueue.async {
        failure?(error)
      }
    }
  }
  
}
