//
//  NewsError.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import Foundation

enum NewsError: String, Error {
    case invalidData = "The data received from the server was invalid. Please try again."
    case requestLimit = "You have reached maximum request"
}
