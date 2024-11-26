//
//  CacheProtocol.swift
//  BaseCode
//
//  Created by orange on 17/05/24.
//

import Foundation
// MARK: - Protocol for Cache 
protocol CacheProtocol {
    // MARK: - AssociatedType Protocol - we are creating this for providing the type to the object
    associatedtype Input = AnyObject
    associatedtype Output = Decodable
    // MARK: - Function for
    func cache(object: Input, forKey key: String) throws
    func getCached(forKey key: String) throws -> Output
    func deleteFromCache(forKey key: String)
}
