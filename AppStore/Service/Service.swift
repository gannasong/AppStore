//
//  Service.swift
//  AppStore
//
//  Created by SUNG HAO LIN on 2020/2/17.
//  Copyright © 2020 SUNG HAO LIN. All rights reserved.
//

import Foundation

class Service {

  static let shared = Service()

  func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
    guard let url = URL(string: urlString) else { return }

    URLSession.shared.dataTask(with: url) { (data, resp, err) in
      if let err = err {
        print("Failed to fetch apps:", err)
        completion([], err)
      }

      guard let data = data else { return }
      do {
        let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
        completion(searchResult.results, nil)
      } catch let jsonErr {
        print("Failed to decode json:", jsonErr)
        completion([], jsonErr)
      }
    }.resume()
  }
}
