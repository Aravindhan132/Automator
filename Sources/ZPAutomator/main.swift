import Foundation
import ShellOut
import SwiftProtobuf
do {
    try CLI().run()
} catch {
    fputs("❌ \(error)", stderr)
    exit(1)
}

