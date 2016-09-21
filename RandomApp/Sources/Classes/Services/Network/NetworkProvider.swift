//
//  NetworkProvider.swift
//  RandomApp
//
//  Created by Ilyas Siraev on 21.09.16.
//  Copyright © 2016 On The Moon. All rights reserved.
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
            success: @escaping ([String : AnyObject]) -> Void,
            failure: @escaping (Error) -> Void) -> URLSessionDataTask? {
    do {
      let request = try request.buildURLRequest()
      let task = self.session.dataTask(with: request,
                                       completionHandler: { [weak self] (data, response, error) in
                                        guard let data = data else {
                                          self?.mainDispatchQueue.async {
                                            failure(error ?? NetworkError.unknown)
                                          }
                                          return
                                        }
                                        
                                        guard let jsonOptional = try? JSONSerialization.jsonObject(with: data, options: []),
                                          let json = jsonOptional as? [String: AnyObject] else {
                                            self?.mainDispatchQueue.async {
                                              failure(NetworkError.invalidResponse)
                                            }
                                            return
                                        }
                                        
                                        self?.mainDispatchQueue.async {
                                          success(json)
                                        }
      })
      
      task.resume()
      return task
      
    } catch let error {
      mainDispatchQueue.async {
        failure(error)
      }
      return nil
    }
  }
  
  func make(request: NetworkRequest,
            success: @escaping (Data) -> Void,
            failure: @escaping (Error) -> Void) -> URLSessionDataTask? {
    do {
      let request = try request.buildURLRequest()
      let task = self.session.dataTask(with: request,
                                       completionHandler: { [weak self] (data, response, error) in
                                        guard let data = data else {
                                          self?.mainDispatchQueue.async {
                                            failure(error ?? NetworkError.unknown)
                                          }
                                          return
                                        }
                                        
                                        self?.mainDispatchQueue.async {
                                          success(data)
                                        }
      })
      
      task.resume()
      return task
      
    } catch let error {
      mainDispatchQueue.async {
        failure(error)
      }
      return nil
    }
  }
  
}
