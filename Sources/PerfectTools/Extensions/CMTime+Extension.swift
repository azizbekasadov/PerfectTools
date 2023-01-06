//
//  CMTime+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

import AVFoundation

extension CMTime {
    public var timeString: String {
        if seconds.isInfinite || seconds.isNaN {
            return ""
        }

        let sInt = Int(seconds)
        let seconds: Int = sInt % 60
        let minutes: Int = (sInt / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
