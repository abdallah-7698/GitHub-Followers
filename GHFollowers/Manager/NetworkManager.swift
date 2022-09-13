//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by MacOS on 21/06/2022.
//

import UIKit


class NetworkManager{
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    
    let cache = NSCache<NSString , UIImage>()
    
    private init(){}
    
    
    func getFollowers(for userName : String , page : Int , completion : @escaping (Result<[Followers] , GFError>)->Void){
        let endPoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endPoint) else{
            completion(.failure(.invalidUserName))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completion(.failure(.unableToComplete))
            }
            // if the response is found make him as HTTP URL Response and thin check the status code if it = 200 it mean good and no error
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Followers].self, from: data)
                completion(.success(followers))
            }catch{
                completion(.failure(.invalidData))
            }
            
        }
        // start thr section
        task.resume()
    }
    
    func getUserInfo(for userName : String , completion : @escaping (Result<User , GFError>)->Void){
        let endPoint = baseURL+"\(userName)"
        guard let url = URL(string: endPoint) else{
            completion(.failure(.invalidUserName))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completion(.failure(.unableToComplete))
            }
            // if the response is found make him as HTTP URL Response and thin check the status code if it = 200 it mean good and no error
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completion(.success(user))
            }catch{
                completion(.failure(.invalidData))
            }
            
        }
        // start thr section
        task.resume()
    }
    
    func downloadImage(from urlString : String , completion : @escaping (UIImage?)-> Void){
        
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString)else{
            completion(nil)
            return}
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response , error in
            guard let self = self ,
                  error == nil ,
                  let response = response as? HTTPURLResponse ,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
            else{
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
    
}
