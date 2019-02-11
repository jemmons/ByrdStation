import Foundation



public enum Unexpected: LocalizedError {
  case missingDocumentDirectory
  
  public var errorDescription: String? {
    switch self {
    case .missingDocumentDirectory:
      return "No available document directory found in the user domain."
    }
  }
}



public enum Invalid: LocalizedError {
  case model(path: URL)
  
  
  public var errorDescription: String? {
    switch self {
    case .model(let url):
      return "The file at “\(url.path)” could not be parsed as a model."
    }
  }
}



public enum Missing: LocalizedError {
  case model(name: String, bundle: Bundle)
  
  
  public var errorDescription: String? {
    switch self {
    case let .model(name, bundle):
      return "Unable to find a model named “\(name)” in bundle “\(bundle.bundlePath)”."
    }
  }
}
