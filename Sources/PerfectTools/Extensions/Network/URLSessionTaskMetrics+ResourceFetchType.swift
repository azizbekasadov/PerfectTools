//
//  URLSessionTaskMetrics+ResourceFetchType.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension URLSessionTaskMetrics.ResourceFetchType: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .localCache:
            return "localCache"
        case .networkLoad:
            return "network"
        case .serverPush:
            return "pushedByServer"
        default:
            return "unknown"
        }
    }
}
