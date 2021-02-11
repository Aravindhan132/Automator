import ShellOut
import SwiftProtobuf
import Foundation

class APIRequester {

    static func triggerLatestUIJSON(onCompletion: ((ZPApp) -> ())? = nil) {
        if let url = URL(string: "http://demo1061542.mockable.io/list_grid") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        do {
                            let model = try ZPApp(jsonUTF8Data: data)
                            print("✅ ✅ Successfully Serialized Model ✅ ✅" , data)
                            onCompletion?(model)
                        }
                        catch let error {
                          print("Not decoded" , error)
                        }
                    } else {
                        print("Un-Formated Data")
                    }
                }.resume()
                guard let sleeping = try? shellOut(to: "sleep", arguments: ["5"]) else {return}
            }
    }

}