import ShellOut
import SwiftProtobuf
import Foundation

class PattenModel: NSObject {
    
    public var patternKey: String = ""
    public var items: [String] = []
    public var originalitems: [String] = []

    public override init() {

    }

}

var screens_datasource: [ScreenModel] = []

class ScreenModel: NSObject {

    public var topNavigationPatterns: [PattenModel] = []
    
    public var bottomNavigationPatterns: [PattenModel] = []

    public var sectionHeaders: [PattenModel] = []

    public var listPatterns: [PattenModel] = []

    public var containerPatterns: [PattenModel] = []

    public var screenKey: String = ""

    public var uuid: String = ""

    public override init() {

    }
}

extension RangeReplaceableCollection where Element: Hashable {
    var orderedSet: Self {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
    mutating func removeDuplicates() {
        var set = Set<Element>()
        removeAll { !set.insert($0).inserted }
    }
}