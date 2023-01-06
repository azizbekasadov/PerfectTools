//
//  NSObject+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension NSObject {
    public var memoryAddress: String {
        return "\(Unmanaged.passUnretained(self).toOpaque())"
    }

    public func copyObject<T: NSObject>() throws -> T? {
        let data = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
    }
}

