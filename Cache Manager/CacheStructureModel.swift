//
//  CacheStructureModel.swift
//  BaseCode
//
//  Created by orange on 17/05/24.
//

import Foundation
// MARK: - Cache Model
struct CacheStructureModel: Decodable {
    var id: UnwrappedKey
    init(from decoder: Decoder) throws {
        //Decode all defined variables..
        self.id = UnwrappedKey(key: "")
    }
    init(id: String) {
        self.id = UnwrappedKey(key: id)
    }
    class UnwrappedKey: NSObject {
        var key: String
        init(key: String) {
            self.key = key
        }
        override var hash: Int { return key.hashValue }
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? UnwrappedKey else {
                return false
            }
            return value.key == key
        }
    }
}
