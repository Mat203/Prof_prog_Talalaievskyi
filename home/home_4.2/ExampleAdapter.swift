//One of the most valuable usage of Adapter -- extract data from different formats to unified form. Let's try this:
import Foundation

class JSONDataProvider {
    func fetchData() -> String {
        return "{\"name\": \"John\", \"age\": 30}"
    }
}

class XMLDataProvider {
    func fetchData() -> String {
        return "<person><name>John</name><age>30</age></person>"
    }
}

protocol DataProvider {
    func getData() -> [String: Any]
}

class JSONDataAdapter: DataProvider {
    private var jsonProvider: JSONDataProvider
    
    init(jsonProvider: JSONDataProvider) {
        self.jsonProvider = jsonProvider
    }
    
    func getData() -> [String: Any] {
        let jsonString = jsonProvider.fetchData()
        let data = jsonString.data(using: .utf8)!
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        return json
    }
}

class XMLDataAdapter: DataProvider {
    private var xmlProvider: XMLDataProvider
    
    init(xmlProvider: XMLDataProvider) {
        self.xmlProvider = xmlProvider
    }
    
    func getData() -> [String: Any] {
        let xmlString = xmlProvider.fetchData()
        var result = [String: Any]()
        
        if let nameRange = xmlString.range(of: "<name>(.*?)</name>", options: .regularExpression) {
            let nameSubstring = xmlString[nameRange]
            let name = nameSubstring.replacingOccurrences(of: "<name>", with: "").replacingOccurrences(of: "</name>", with: "")
            result["name"] = name
        }
        
        if let ageRange = xmlString.range(of: "<age>(.*?)</age>", options: .regularExpression) {
            let ageSubstring = xmlString[ageRange]
            let age = ageSubstring.replacingOccurrences(of: "<age>", with: "").replacingOccurrences(of: "</age>", with: "")
            result["age"] = Int(age)
        }
        
        return result
    }
}


