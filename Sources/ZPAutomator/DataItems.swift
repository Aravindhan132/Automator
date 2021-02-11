import Foundation

class DataItemsGenerator {

    static func dataitemModelContents() -> String {
         return """
        
            import Foundation
            import UIKit

            public enum Values {
                case text(_ text: String)
                case attributed(_ attributed: NSAttributedString)
                case html(_ test: String)
                case image(UIImage)
            }
            
            public enum Colors {
                case bgColor(_ colorValue: UIColor)
                case textColor(_ color: UIColor)
                case forgroundColor(_ color: UIColor)
                case borderColor(_ color: UIColor)
                case borderWidth(CGFloat)
            }
            
             
            public typealias TextValues = (text: String? , attributed: NSAttributedString? , webContent: String?)
            
            public typealias ImageValues = (image: UIImage? , icon: UIFont?)

            //public protocol Base_DataProvider { }

            public class DataItem: NSObject  {
                
                public var styles: [Colors] = [];
                public var update: (() -> ())? = nil;
                public var imageData: ImageValues = ImageValues(nil , nil);
                public var textData: TextValues = TextValues(nil , nil , nil);
                public static var shared: DataItem {
                        let datamodel = DataItem.init()
                        datamodel.styles.removeAll()
                        return datamodel
                    }
                
                public override init() {
        
                }

                @discardableResult public func setData(_ property: Values) -> DataItem {
                    switch property {
                    case let .text(textvalue):
                        self.textData.text = textvalue
                    case let .attributed(attributedvalue):
                        self.textData.attributed = attributedvalue
                    case let .html(htmlvalue):
                        self.textData.webContent = htmlvalue
                    case let .image(imagevalue):
                        self.imageData.image = imagevalue
                    }
                    return self
                }

                @discardableResult public func setStyle(property: Colors) -> DataItem {
                    self.styles.append(property)
                    return self
                }
                
            }

            

            public protocol ListProtocol {
                 func initializedData(isCompleted: ((Bool) -> ())?)
                 func prepareNumberOfSections() -> Int
                 func prepareNumberofRows(in section: Int) -> Int
                 func prepareDataForCell(in indexpath: IndexPath) -> Base_DataProvider
            }


            public protocol DetailProtocol {
                
            }

           

        """
    }

}