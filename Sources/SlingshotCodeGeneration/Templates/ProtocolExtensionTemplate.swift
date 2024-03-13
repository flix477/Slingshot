import Foundation

struct ProtocolExtensionTemplate: Template {
    func generate(_ templateName: String,
                  for type: Configuration.StructMetadata,
                  with configuration: Configuration) throws -> (name: String, contents: String) {
        let root = "Resources/Templates/\(templateName)"
        let templatePath = Bundle.module.url(forResource: "\(root)/\(templateName)", withExtension: "swifttemplate")!
        let template = String(data: try Data(contentsOf: templatePath), encoding: .utf8)!
        let typeArg = type.elements ?? type.arguments?.first ?? ""
        let args = [#"\(type)"#: type.name,
                    #"\(typeArg)"#: typeArg,
                    #"\(fullyQualifiedType)"#: type.type == .concrete ? type.name : "\(type.name)<\(typeArg)>"]
        
        let contents = apply(template: template, with: args)
        
        return (name: "\(type.name)+\(templateName).swift", contents: contents)
    }
    
    private func apply(template: String, with arguments: [String: String]) -> String {
        arguments.reduce(template) { $0.replacingOccurrences(of: $1.key, with: $1.value) }
    }
}
