//
//  GFError.swift
//  GHFollowers
//
//  Created by MacOS on 26/07/2022.
//

import Foundation

enum GFError : String , Error{
    case invalidUserName    = "This user name creted invalid request Please try again."
    case unableToComplete   =  "Unable to complete your request . please check your internet connection"
    case invalidResponse    = "invalid response from the server. please try again."
    case invalidData        = "The data you get from the server was invalid. please try again."
    case unableToFaourire   = "There is an error fovouriting this user. please try again."
    case alreadyInFavourite = "This user already in your favourites , you must REALLY like him!"
}
