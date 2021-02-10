extension FileTemplate {

static func prepareFetchDataContent() -> String {
        var begin_content = ""
        var starting_template = "extension Base_DataProvider { \n public func getDataItem(key: String , screenID: String) -> DataItem? {  \n"
        var ending_template = "\n } \n"

        var content = ""
        screens_datasource.enumerated().forEach { (index , eachscreen) in

            content += "\(index == 0 ? " if" : "\n else if") screenID == \"\(eachscreen.uuid)\" { \n"
            var switch_content = "switch key { \n"

            if eachscreen.listPatterns.count > 0 {

                // LIST ITEMS
                    eachscreen.listPatterns.enumerated().forEach { (index , eachpattern) in

                                eachpattern.originalitems.enumerated().forEach { (second_index , eachitem) in
                                    switch_content += "\n case \"\(eachitem )\": return (self as? \(eachpattern.patternKey))?.\(eachpattern.items[second_index]) ; \n"
                                }

                    }

            }

                // TOP NAVIGATION 
                    eachscreen.topNavigationPatterns.enumerated().forEach { (index , eachpattern) in

                                eachpattern.originalitems.enumerated().forEach { (second_index , eachitem) in
                                    switch_content += "\n case \"\(eachitem )\": return (self as? \(eachpattern.patternKey))?.\(eachpattern.items[second_index]) ; \n"
                                }

                    }

                // SECTION HEADERS 
                    eachscreen.sectionHeaders.enumerated().forEach { (index , eachpattern) in

                                eachpattern.originalitems.enumerated().forEach { (second_index , eachitem) in
                                    switch_content += "\n case \"\(eachitem )\": return (self as? \(eachpattern.patternKey))?.\(eachpattern.items[second_index]) ; \n"
                                }

                    }

                // CONTAINER ITEMS 
                    eachscreen.containerPatterns.enumerated().forEach { (index , eachpattern) in

                                eachpattern.originalitems.enumerated().forEach { (second_index , eachitem) in
                                    switch_content += "\n case \"\(eachitem )\": return (self as? \(eachpattern.patternKey))?.\(eachpattern.items[second_index]) ; \n"
                                }

                    }
            
                    switch_content += "default: return nil; \n} \n"
                    content += switch_content
        
            
            content += "\n }\n "

        }

        starting_template += content
        starting_template += " return nil; \n } \n }"
        return starting_template
    }

}