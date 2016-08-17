import Cocoa

class Date : CustomStringConvertible {
    let calendar = NSCalendar.currentCalendar()
    var dateVal: NSDate
    let myInstanceNumber: Int
    static var instanceCounter: Int = 0

    enum DateOffset {
        case    Seconds
        case    Minutes
        case    Hours
        case    Days
        case    Weeks
        case    Months
        case    Quarters
        case    Years
        case    Decades
        case    Centuries
    }
    
    var description: String {
        return dateVal.debugDescription
    }
    
    var year: Int {
        get {
            return calendar.components(NSCalendarUnit.Year, fromDate: dateVal).year
        }
    }
    
    var month: Int {
        get {
            return calendar.components(NSCalendarUnit.Month, fromDate: dateVal).month
        }
    }
    
    var day: Int {
        get {
            return calendar.components(NSCalendarUnit.Day, fromDate: dateVal).day
        }
    }
    
    var hour: Int {
        get {
            return calendar.components(NSCalendarUnit.Hour, fromDate: dateVal).hour
        }
    }
    
    var minute: Int {
        get {
            return calendar.components(NSCalendarUnit.Minute, fromDate: dateVal).minute
        }
    }

    var second: Int {
        get {
            return calendar.components(NSCalendarUnit.Second, fromDate: dateVal).second
        }
    }
    
    var dayOfWeek: Int {
        get {
            return calendar.components(NSCalendarUnit.Weekday, fromDate: dateVal).weekday
        }
    }

    var milliseconds: Int64 {
        get {
            return Int64(Double(dateVal.timeIntervalSince1970) * 1000.0)
        }
    }
    
    init(_ date: NSDate? = nil) {
        if let d = date {
            dateVal = d
        } else {
            dateVal = NSDate()
        }
        self.myInstanceNumber = Date.instanceCounter
//        print("Date object instance \(self.myInstanceNumber) constructed")
        Date.instanceCounter += 1
    }
    
    deinit {
//        print("Date object instance \(self.myInstanceNumber) destructing")
    }
    
    func add(offset: Int, _ offsetType: DateOffset) -> Date {
        let v = NSDateComponents()
        
        switch offsetType {
        case    .Seconds:
            v.second = offset
            
        case    .Minutes:
            v.minute = offset
            
        case    .Hours:
            v.hour = offset
          
        case    .Days:
            v.day = offset
            
        case    .Months:
            v.month = offset
            
        case    .Years:
            v.year = offset
            
        default:
            return self
        }

        return Date(calendar.dateByAddingComponents(v, toDate: dateVal, options: NSCalendarOptions()))
    }
    
    func subtract(offset: Int, _ offsetType: DateOffset) -> Date {
        return add(-offset, offsetType)
    }
}

var today = Date()

print(today)
today = today.add(2, .Days).subtract(2, .Days).add(1, .Years).add(5, .Months)
print(today)
print("Day of week is \(today.dayOfWeek)")

