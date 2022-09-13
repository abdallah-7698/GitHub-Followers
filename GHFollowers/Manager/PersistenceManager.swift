//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by MacOS on 27/07/2022.
//

import Foundation

enum persistenceActionType{
    case add , remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum keys { static let favourites = "favourites"}
    
    static func update(with favourite : Followers , actionType : persistenceActionType , completion : @escaping (GFError?)-> Void){
        retreveFavourites { result in
            switch result{
            case .success(var favourites):
                
                switch actionType {
                case .add:
                    // check if the one is existet
                    guard !favourites.contains(favourite) else{
                        completion(.alreadyInFavourite)
                        return
                    }
                    favourites.append(favourite)
                case .remove:
                    favourites.removeAll {$0.login == favourite.login}
                }
                // not tis var
                completion(save(favoorites: favourites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retreveFavourites(completion : @escaping (Result<[Followers] ,GFError>)->Void){
        // if first time will not have any objects and will get no object but if contain objects will decode then
        guard let favouritesData = defaults.object(forKey: keys.favourites) as? Data else{
            completion(.success([]))
            return
        }
        do{
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Followers].self, from: favouritesData)
            completion(.success(favourites))
        }catch{
            completion(.failure(.unableToFaourire))
        }
    }
    
    // we encode it into data so if done correct will return nil elsereturn error
    static func save(favoorites : [Followers])-> GFError?{
        do{
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favoorites)
            defaults.set(encodedFavourites, forKey: keys.favourites)
            return nil
        }catch{
            return .unableToFaourire
        }
    }
    
    
}
