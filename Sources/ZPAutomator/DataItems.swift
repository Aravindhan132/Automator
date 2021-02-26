import Foundation

class DataItemsGenerator {

    static func dataitemModelContents() -> String {
         return """
        
        import Foundation
        import UIKit

        public enum Values {
                case plain(_ text: String)
                case progress(_ value: CGFloat)
                case placeHolderString(_ text: String)
                case attributed(_ attributed: NSAttributedString)
                case attributedPlaceHolder(_ text: NSAttributedString)
                case url(_ text: String)
                case image(UIImage)
                case icon(_ text: NSAttributedString)
                case checked(_ enabled: Bool)
                case list(_ value: ZBListProtocol)
        }

        public typealias TextValues = (plainString: String?, placeHolderString: String?, attributedString: NSAttributedString?, attributedPlaceHolderString: NSAttributedString?, urlString: String? , progressValue: CGFloat? , checked: Bool?)

        public typealias ImageValues = (image: UIImage?, icon: NSAttributedString?, placeHolderImage: UIImage?, placeHolderIcon: NSAttributedString?, placeHolderText: String?)

        public protocol ZPDataProvider { }
            
        public typealias DataValues = (textData: TextValues? , imageData: ImageValues?)
            
        public class ZPDataItem: NSObject  {
                
                public var isHide: Bool = false

                public var styleInput: Any? = nil;

                public var update: (() -> ())? = nil;

                public var dataValue: (DataValues) = DataValues(TextValues(nil , nil, nil , nil, nil , nil , nil) ,
                                                    ImageValues(nil , nil, nil , nil, nil))

                public var listDataSource: ZBListProtocol? = nil

                public static var shared: ZPDataItem {
                    let datamodel = ZPDataItem.init()
                    return datamodel
                }
                
                public override init() {
        
                }
                
                
        }

        extension ZPDataItem {

                @discardableResult public func setData(_ property: Values) -> ZPDataItem {
                    switch property {
                        case let .plain(textvalue):
                            self.dataValue.textData?.plainString = textvalue
                        case let .placeHolderString(placeholder):
                            self.dataValue.textData?.placeHolderString = placeholder
                        case let .attributed(attributedvalue):
                            self.dataValue.textData?.attributedString = attributedvalue
                        case let .attributedPlaceHolder(attributedPlaceHolder):
                            self.dataValue.textData?.attributedPlaceHolderString = attributedPlaceHolder
                        case let .url(urlvalue):
                            self.dataValue.textData?.urlString = urlvalue
                        case let .image(imagevalue):
                            self.dataValue.imageData?.image = imagevalue
                        case let .icon(iconvalue):
                            self.dataValue.imageData?.icon = iconvalue
                        case let .progress(progressvalue):
                            self.dataValue.textData?.progressValue = progressvalue
                        case let .checked(enabledvalue):
                            self.dataValue.textData?.checked = enabledvalue
                        case let .list(listdatasource):
                            self.listDataSource = listdatasource
                        }
                    return self
                }

                @discardableResult public func setListDatasouce(_ listdatasource: ZBListProtocol) -> ZPDataItem {
                    self.listDataSource = listdatasource
                    return self
                }
                
        }
           

        public class ZDCollapsingScrollContext: NSObject {
                public var maxOffsetY: CGFloat = 0
                public var outerOffset: CGPoint = CGPoint.zero
                public var innerOffset: CGPoint = CGPoint.zero
        }         

        """
    }

}