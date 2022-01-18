//
//  Result.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//


import Foundation

enum Result<T> {
    
    case success(T)
    case failure(Error)
}
