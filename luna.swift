//
//  luna.swift
//  Orrery
//

import Foundation

class Luna {
    var observer: GeographicPosition?
    var moment: Moment?
    var events: LunarEvents?
    var position: HorizontalPosition?
    var illumination: LunarIllumination?
    
    init(_ observer: GeographicPosition, _ moment: Moment) {
        self.observer = observer
        self.moment = moment
    }
}

class LunarIllumination {
    var fraction: Double?
    var phase: Double?
    var angle: Radians?
}

class LunarEvents {
    var rise: EventDuration?
    var set: EventDuration?
}
