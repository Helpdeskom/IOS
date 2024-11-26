//
//  CacheManager.swift
//  BaseCode
//
//  Created by orange on 17/05/24.
//

import Foundation
// MARK: - Generic class for structure wrapper
final class StructWrapper<Element: Decodable>: NSObject {
    let valueTyped: Element
    init(valueTyped: Element) {
        self.valueTyped = valueTyped
    }
}
// MARK: - Class for CacheManager
final class CacheManager {
    // Given name using typealias
    typealias Input = StructWrapper
    typealias Output = Decodable
    // Property for Cache
    let cache = NSCache<CacheStructureModel.UnwrappedKey, StructWrapper<CacheStructureModel>>()
    // Enum for Response from the cache
    enum Error: Swift.Error {
        case typeCasting
        case cantGetFromCache
    }
}
// MARK: - Extension for cache manager for Generic Function
extension CacheManager: CacheProtocol {
    // Function for GET data from Cache
    func getCached<Output>(forKey key: String) throws -> Output {
        let key: CacheStructureModel.UnwrappedKey = CacheStructureModel.UnwrappedKey(key: key)
        guard let wrapper = cache.object(forKey: key) as? StructWrapper else {
            throw Error.typeCasting
        }
        guard let worker = wrapper.valueTyped as? Output else { throw Error.typeCasting }
        return worker
    }
    func cache<Input>(object: Input, forKey key: String) throws {
        guard let object = object as? CacheStructureModel else { throw Error.typeCasting }
        let wrapper: StructWrapper<CacheStructureModel> = StructWrapper(valueTyped: object)
        cache.setObject(wrapper, forKey: wrapper.valueTyped.id)
    }
    // Function for DELETE data from Cache
    func deleteFromCache(forKey key: String) {
        let key: CacheStructureModel.UnwrappedKey = CacheStructureModel.UnwrappedKey(key: key)
        cache.removeObject(forKey: key)
    }
}
