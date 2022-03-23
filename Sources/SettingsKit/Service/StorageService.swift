import Foundation
//import class Foundation.Bundle

struct StorageService {
    
    enum StorageError: Error {
        case noFilePathError(String)
    }
    
    func getControlPanel(from fileName: String) -> [SettingsSection] {
        
        if let controls: [SettingsSection] = decodeJson(at: fileName)  {
            return controls
        }
        
        return []
    }
    
    
    func decodeJson<T: Decodable> (at path: String) -> T {
        
        var result: T!
        print("path:", path)
        
        do {
            let filePath: URL
            
            if let bundleFilePath = Bundle.module.url(forResource: path, withExtension: "json") {
                filePath = bundleFilePath
            } else if let mainFilePath = Bundle.main.url(forResource: path, withExtension: "json") {
                filePath = mainFilePath
            } else {
                throw StorageError.noFilePathError("Couldn't initialize the filePath")
            }
            
            print("filePath:", filePath)
            
            let data = try Data(contentsOf: filePath)
            print("pathData:", data)
            result = try JSONDecoder().decode(T.self, from: data)
            
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print(error)
        }
        
        return result
    }
    
}

//private class BundleFinder {}
//
//extension Foundation.Bundle {
//    /// Returns the resource bundle associated with the current Swift module.
//    static var module: Bundle = {
//        let bundleName = "SettingsKit"
//
//        let candidates = [
//            // Bundle should be present here when the package is linked into an App.
//            Bundle.main.resourceURL,
//
//            // Bundle should be present here when the package is linked into a framework.
//            Bundle(for: BundleFinder.self).resourceURL,
//
//            // For command-line tools.
//            Bundle.main.bundleURL,
//        ]
//
//        for candidate in candidates {
//            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
//            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
//                return bundle
//            }
//        }
//        fatalError("unable to find bundle named SettingsKit")
//    }()
//}

