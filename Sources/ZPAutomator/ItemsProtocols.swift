extension FileTemplate {

     static func prepareScreeenContent(screen: ScreenModel) -> String {
        
        var begin_content = ""

// PREPARE LIST ITEM CONTENT
        screen.listPatterns.forEach({ (eachPattern) in
            var initial_protocol_template = "public protocol \(eachPattern.patternKey): Base_DataProvider { \n"

            eachPattern.items.forEach({ (eachitem) in
                initial_protocol_template += "\t var \(eachitem): (DataItem) {get}; \n"
            })

            var end_protocol_template = "} \n"

            let total = initial_protocol_template + end_protocol_template
            begin_content += total
        })

// PREPARE TOP NAVIGATION CONTENT
        screen.topNavigationPatterns.forEach({ (eachPattern) in
            var initial_protocol_template = "public protocol \(eachPattern.patternKey): Base_DataProvider { \n"

            eachPattern.items.forEach({ (eachitem) in
                initial_protocol_template += "\t var \(eachitem): (DataItem) {get}; \n"
            })

            var end_protocol_template = "  } \n"

            let total = initial_protocol_template + end_protocol_template
            begin_content += total
        })

// PREPARE Bottom NAVIGATION CONTENT
        screen.bottomNavigationPatterns.forEach({ (eachPattern) in
            var initial_protocol_template = "public protocol \(eachPattern.patternKey): Base_DataProvider { \n"

            eachPattern.items.forEach({ (eachitem) in
                initial_protocol_template += "\t var \(eachitem): (DataItem) {get}; \n"
            })

            var end_protocol_template = "  } \n"

            let total = initial_protocol_template + end_protocol_template
            begin_content += total
        })

// PREPARE SEECTION HEADER CONTENT
        screen.sectionHeaders.forEach({ (eachPattern) in
            var initial_protocol_template = "public protocol \(eachPattern.patternKey): Base_DataProvider { \n"

            eachPattern.items.forEach({ (eachitem) in
                initial_protocol_template += "\t var \(eachitem): (DataItem) {get}; \n"
            })

            var end_protocol_template = "  } \n"

            let total = initial_protocol_template + end_protocol_template
            begin_content += total
        })

// PREPARE CONTAINER CONTENT
        screen.containerPatterns.forEach({ (eachPattern) in
            var initial_protocol_template = "public protocol \(eachPattern.patternKey): Base_DataProvider { \n"

            eachPattern.items.forEach({ (eachitem) in
                initial_protocol_template += "\t var \(eachitem): (DataItem) {get}; \n"
            })

            var end_protocol_template = "  } \n"

            let total = initial_protocol_template + end_protocol_template
            begin_content += total
        })



        let topNavigationpattern = screen.topNavigationPatterns.first?.patternKey ?? ""
        var totalScreenProtocol = (screen.listPatterns.count == 0 && screen.containerPatterns.count == 0) ? "\n public protocol \(screen.screenKey)_DataProvider: \(topNavigationpattern)" : "\n public protocol \(screen.screenKey)_DataProvider: \(topNavigationpattern) , "

        screen.listPatterns.enumerated().forEach { (index , eachpattern) in
            let content = (index == (screen.listPatterns.count - 1)) ? "\(eachpattern.patternKey)  { \n }" : "\(eachpattern.patternKey) , "
            totalScreenProtocol += content
        }

        screen.containerPatterns.enumerated().forEach { (index , eachpattern) in
            let content = (index == (screen.containerPatterns.count - 1)) ? "\(eachpattern.patternKey) " : "\(eachpattern.patternKey) , "
            totalScreenProtocol += content
        }

        if screen.listPatterns.count == 0 {
            totalScreenProtocol += " { } \n "
        }
        
        return begin_content + totalScreenProtocol
    }


    
}