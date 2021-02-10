import ShellOut
import SwiftProtobuf
import Foundation

enum FileTemplate {
    
    static func prepareFileGenerationModels(_ onCompletion: (() -> ())? = nil) {
            APIRequester.triggerLatestUIJSON { model in
                
                FileTemplate.prepareScreensDataSources(model: model)

                 onCompletion?()

            }
    }
 
    static func prepareScreensDataSources(model: ZPApp) {
            model.screens.forEach({ (eachScreen) in
                    var screenmodel = ScreenModel()
                    screenmodel.screenKey = eachScreen.module
                    screenmodel.uuid = eachScreen.uid

                    // FOR TOP NAVIGATION HEADER
                     screenmodel.topNavigationPatterns.append(eachScreen.prepareNavigationDataSource())

                    // FOR BOTTOM NAVIGATION HEADER
                     screenmodel.bottomNavigationPatterns.append(eachScreen.prepareBottomNavigationDataSource())

                    // FOR SECTION HEADER
                    screenmodel.sectionHeaders = eachScreen.prepareSectionHeaderPatternsDataSource()

                    // FOR LIST ITEMS
                    screenmodel.listPatterns = eachScreen.prepareCellPatternsDataSource()

                    // FOR CONTAINER ITEMS
                    screenmodel.containerPatterns = eachScreen.prepareContainerPatternsDataSource()

                    screens_datasource.append(screenmodel)

            })

    }

 
   
     
}

