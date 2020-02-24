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

  func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
    fetchGenericJSONData(urlString: urlString, completion: completion)
  }

  func fetchGames(completion: @escaping (AppGroup? , Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
    fetchAppGroup(urlString: urlString, completion: completion)
  }

  func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> Void) {
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
    fetchAppGroup(urlString: urlString, completion: completion)
  }

  // helper
  func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
    fetchGenericJSONData(urlString: urlString, completion: completion)
  }

  func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
    let urlString = "https://api.letsbuildthatapp.com/appstore/social"
    fetchGenericJSONData(urlString: urlString, completion: completion)
  }

  // declare generic json function
  func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
    guard let url = URL(string: urlString) else { return }

    print("T is type:", T.self)

    URLSession.shared.dataTask(with: url) { (data, resp, error) in
      if let error = error {
        completion(nil, error)
        return
      }

      do {
        let objects = try JSONDecoder().decode(T.self, from: data!)
        completion(objects, nil)
      } catch {
        completion(nil, error)
        print("Failed to decode:", error)
      }
    }.resume()
  }
}
