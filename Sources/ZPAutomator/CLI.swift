import Foundation
import ShellOut

public struct CLI {
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else {
            return outputHelpText()
        }
        
        switch arguments[1] {
        case "new":
            try createNewPlatformProject()
            
        case "update":
            try createNewPlatformProject()
            
        case "install":
            try platformInstall()

        case "rm":
            UserDefaults.standard.set(nil, forKey: "path")
            print("Account removed Successfully 🛠 ")

        case "auth":
            UserDefaults.standard.set(arguments[2], forKey: "path")
            print("Account added Successfully 📩 📩 📩")

        case "profile":
            
            if let profile = UserDefaults.standard.string(forKey: "path") {
                print("Your account located at 🔎 ")
                print(profile)
            } else {
                print("Not Account Linked ಠ_ಠ")
            }
            

        case ".dev":
            print("Development Mode")
            let projectPath = arguments[2]
            if let directoryPath = try? shellOut(to: "find . -type d -name" , arguments: ["CodeGeneration"]) {
                print("entered" , directoryPath)
            //    if let created = try? createNewPlatformProject2(directoryPath) {
            //                if let comments2 = try? shellOut(to:  "cd \(projectPath) && pod install", arguments: [""]) {
            //                         print(comments2)
            //                }
            //    } 

               do {
                    let created = try createNewPlatformProject2(directoryPath)
                    print(created)
               } catch {
                    print("Uncompleted Completion")
               }
            } else {
                print("path not found")
            }
                 
            
        default:
            outputHelpText()
        }
    }
    
    private func platformInstall() throws {
        
        if let comments = try? shellOut(to: "pod", arguments: ["install"]) {
            
            if comments.contains("Pod installation complete") {
                print("*****Finished*****")
            }
            
            print(comments)
        }
        
    }
    
    
    
    private func replaceFile(at path: String, with contents: String) throws {
        try shellOut(to: .removeFile(from: path))
        let url = URL(fileURLWithPath: path)
        try contents.write(to: url, atomically: true, encoding: .utf8)
    }
    
    private func createNewPlatformProject() throws {
        
        // if let podInstall = try? shellOut(to: .installCocoaPods())  {
        //     print("pod installed" , podInstall)

            
            
            if let removed = try?  shellOut(to: "rm -r", arguments: ["Automator"]) {
                print("New Files Updating ⏰ ⏰ ⏰")
            }
            
            guard let sleeping = try? shellOut(to: "sleep", arguments: ["5"]) else {return}
            
            if let removed = try? shellOut(to: "mkdir", arguments: ["Automator"]) {
                
            }
            
            print("🚂 🚂 🚂 New Files Updated")
            
            // let currentDirectory = try getCurrentDirectory()
            
            
            
            // Create DataItemModel Classes
            try replaceFile(
                at: "Automator/ZPDataItemModel.swift",
                with: DataItemsGenerator.dataitemModelContents()
            )
            
            FileTemplate.prepareFileGenerationModels {
                screens_datasource.forEach({ (eachscreen) in
                    let path = "Automator/\(eachscreen.screenKey)_DataProvider.swift"
                    let url = URL(fileURLWithPath: path)
                    guard let result4 = try? shellOut(to: .removeFile(from: path)) ,
                          let content4 = try? FileTemplate.prepareScreeenContent(screen: eachscreen).write(to: url, atomically: true, encoding: .utf8)
                    else { print("Retured --->"); return}
                    
                })
                
                let path = "Automator/FetchDataComponent.swift"
                let url = URL(fileURLWithPath: path)
                guard let result4 = try? shellOut(to: .removeFile(from: path)) ,
                      let content4 = try? FileTemplate.prepareFetchDataContent().write(to: url, atomically: true, encoding: .utf8)
                else { print("Retured --->"); return}
                
            }
            
            
            
            
            print("🚀 Here You Go!!! , Thanks for Using Platform Automator.")
            
        // } else {
        //     print("Error")
        // }
        
        
    }

    private func createNewPlatformProject2(_ path: String) throws {
        
            
            print("🚂 🚂 🚂 New Files Updated")
           
           
           
            // Create DataItemModel Classes
            try replaceFile(
                at: "\(path)/ZPDataItemModel.swift",
                with: DataItemsGenerator.dataitemModelContents()
            )
            
            FileTemplate.prepareFileGenerationModels {
                screens_datasource.forEach({ (eachscreen) in
                    let path = "\(path)/\(eachscreen.screenKey)_DataProvider.swift"
                    let url = URL(fileURLWithPath: path)
                    guard let result4 = try? shellOut(to: .removeFile(from: path)) ,
                          let content4 = try? FileTemplate.prepareScreeenContent(screen: eachscreen).write(to: url, atomically: true, encoding: .utf8)
                    else { print("Retured --->"); return}
                    
                })
                
                let path = "\(path)/FetchDataComponent.swift"
                let url = URL(fileURLWithPath: path)
                guard let result4 = try? shellOut(to: .removeFile(from: path)) ,
                      let content4 = try? FileTemplate.prepareFetchDataContent().write(to: url, atomically: true, encoding: .utf8)
                else { print("Retured --->"); return}
                
            }
            
            
            
            
            print("🚀 Here You Go!!! , Thanks for Using Platform Automator.")
    
        
        
    }
    
    
    
    
    private func getCurrentDirectory() throws -> (fullPath: String, currentPath: String) {
        let fullPath = try shellOut(to: "pwd")
        guard let currentPath = fullPath.components(separatedBy: "/").last else {
            throw Error.invalidPath
        }
        return (fullPath, currentPath)
    }
    
    
}

private extension CLI {
    func outputHelpText() {
        print("""
        Platform Command Line Interface
        ------------------------------
        Interact with the Platform (ZOHO PLATFORM BUILDER) from
        the command line, to create new Swift Platform projects,
        or package your BUILDER , BRIDGE into a zip file.
        Available commands:
        - new: Create a new Zoho Platform CoreBridge Autogeneration Files.
        - update: Update the CoreBridge.
        """)
    }
    
    enum Error: LocalizedError {
        case inputError
        case invalidPath
        
        var errorDescription: String? {
            switch self {
            case .inputError:
                return "Invalid input. Please try again."
            case .invalidPath:
                return "The path specified doesn't exist."
            }
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
