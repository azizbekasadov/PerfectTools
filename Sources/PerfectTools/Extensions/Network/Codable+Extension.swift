//
//  File.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension Encodable {
    public typealias Parameters = [String: Any]
    
    public var dictionary: Parameters? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }

        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
