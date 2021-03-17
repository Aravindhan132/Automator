
extension ZPApp {
    
    public func getScreen(id: String) -> ZPScreen? {
        
        guard let dataMessage = self.screens.first(where: { (dataMessage) -> Bool in
            return dataMessage.uid == id
        }) else {
            print("No screens found")
            return nil
        }
        
        return dataMessage
    }

}

extension ZPScreen {
    
    public func getSegment(ofsegment segmentType: ZPSegment.ZPSegmentType) -> ZPSegment? {
        let segment = self.segments.first(where: { (segment) -> Bool in
            return segment.segmentType == segmentType
        })
        return segment
    }
    
}

extension ZPItemType {
    
    public var isHolderView: Bool {
        
        switch self {
        case .hStack , .vStack , .zStack :
            return true
        default:
            return false
        }
    }
    
    public var isCustomHolderView: Bool {
           
           switch self {
           case .tabLayoutViewPager, .tabView, .tabViewIndicator, .pagingView , .scrollView:
               return true
           default:
               return false
           }
       }
    
}

extension ZPScreen {
    
    func prepareNavigationDataSource() -> PattenModel {
        
        func prepareDynamicItems(item: ZPItem , model: inout PattenModel , isNative: Bool) {
            
            if isNative {
                model.originalitems.append(item.key)
                model.items.append("\(item.key)")
            }
            
            item.items.forEach { (eachitem) in
                if eachitem.itemType.isHolderView {
                    prepareDynamicItems(item: eachitem , model: &model , isNative: isNative)
                } else {
                    model.originalitems.append(eachitem.key)
                    model.items.append("\(eachitem.key)")
                }
            }
        }
        
        let topNavigationBar = self.segments.filter({$0.segmentType == .topNavigationBar}).first
        var model = PattenModel()
        model.patternKey = "\(self.module)_TopNavigation_DataProvider"

        topNavigationBar?.patterns.forEach({ (eachpattern) in
            prepareDynamicItems(item: eachpattern , model: &model, isNative: true)
        })

        return model
    }


    func prepareBottomNavigationDataSource() -> PattenModel {
        
        func prepareDynamicItems(item: ZPItem , model: inout PattenModel , isNative: Bool) {
            
            item.items.forEach { (eachitem) in
                if eachitem.itemType.isHolderView {
                    prepareDynamicItems(item: eachitem , model: &model , isNative: isNative)
                } else {
                    model.originalitems.append(eachitem.key)
                    model.items.append("\(eachitem.key)")
                }
            }
        }
        
        let topNavigationBar = self.segments.filter({$0.segmentType == .bottomNavigationBar}).first
        var model = PattenModel()
        model.patternKey = "\(self.module)_BottomNavigation_DataProvider"

        topNavigationBar?.patterns.forEach({ (eachpattern) in
            prepareDynamicItems(item: eachpattern , model: &model, isNative: true)
        })

        return model
    }
    
    func prepareCellPatternsDataSource() -> [PattenModel] {
        let listitems = self.segments.filter({$0.segmentType == .listItem}).first
        var totalpatterns: [PattenModel] = []
        
        func prepareDynamicItems(item: ZPItem , model: inout PattenModel , patternName: String) {
            item.items.forEach { (eachitem) in
                if eachitem.itemType.isHolderView {
                    prepareDynamicItems(item: eachitem , model: &model , patternName: patternName)
                } else {
                    model.originalitems.append(eachitem.key)
                    model.items.append("\(eachitem.key)")
                }
            }
        }
        
        
        listitems?.patterns.forEach({ (eachPattern) in
            var patternmodel = PattenModel()
            patternmodel.patternKey = "\(self.module)_\(eachPattern.key)_DataProvider"
            prepareDynamicItems(item: eachPattern, model: &patternmodel, patternName: eachPattern.key)
            patternmodel.items.removeDuplicates() 
            patternmodel.originalitems.removeDuplicates() 
            totalpatterns.append(patternmodel)
        })
        
        return totalpatterns
    }
    
    func prepareSectionHeaderPatternsDataSource() -> [PattenModel] {
        let listitems = self.segments.filter({$0.segmentType == .sectionHeader}).first
        var totalpatterns: [PattenModel] = []
        
        func prepareDynamicItems(item: ZPItem , model: inout PattenModel , patternName: String) {
            item.items.forEach { (eachitem) in
                if eachitem.itemType.isHolderView {
                    prepareDynamicItems(item: eachitem , model: &model , patternName: patternName)
                } 
                 else if eachitem.itemType.isCustomHolderView {
                    model.originalitems.append(eachitem.key)
                    model.items.append("\(eachitem.key)")
                    prepareDynamicItems(item: eachitem , model: &model , patternName: patternName)
                }
                else {
                    model.originalitems.append(eachitem.key)
                    model.items.append("\(eachitem.key)")
                }
            }
        }
        
        listitems?.patterns.forEach({ (eachPattern) in
            if totalpatterns.filter({$0.patternKey == eachPattern.key}).count > 0 {return}
            var patternmodel = PattenModel()
            patternmodel.patternKey = "\(self.module)_SectionHeader_\(eachPattern.key)_DataProvider"
            prepareDynamicItems(item: eachPattern, model: &patternmodel, patternName: eachPattern.key)
            patternmodel.items.removeDuplicates() 
            patternmodel.originalitems.removeDuplicates() 
            totalpatterns.append(patternmodel)
        })
        
        return totalpatterns
    }

    func prepareContainerPatternsDataSource() -> [PattenModel] {
        let listitems = self.segments.filter({$0.segmentType == .container}).first
        var totalpatterns: [PattenModel] = []
        
        func prepareDynamicItems(item: ZPItem , model: inout PattenModel , patternName: String) {
            item.items.forEach { (eachitem) in
                if eachitem.itemType.isHolderView {
                    prepareDynamicItems(item: eachitem , model: &model , patternName: patternName)
                } 
                else if eachitem.itemType.isCustomHolderView {
                    model.originalitems.append(eachitem.key)
                    model.items.append("\(eachitem.key)")
                    prepareDynamicItems(item: eachitem , model: &model , patternName: patternName)
                }
                else {
                    model.originalitems.append(eachitem.key)
                    model.items.append("\(eachitem.key)")
                }
            }
        }
        
        
        listitems?.patterns.forEach({ (eachPattern) in
            var patternmodel = PattenModel()
            patternmodel.patternKey = "\(self.module)_Container_\(eachPattern.key)_DataProvider"
            prepareDynamicItems(item: eachPattern, model: &patternmodel, patternName: eachPattern.key)
            patternmodel.items.removeDuplicates() 
            patternmodel.originalitems.removeDuplicates() 
            totalpatterns.append(patternmodel)
        })
        

        return totalpatterns
    }
}