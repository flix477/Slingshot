import Foundation
import Yams

@main
@available(macOS 13.0.0, *)
struct SlingshotCodeGeneration {
    enum CodeGenerationError: Error {
        case invalidArguments
        case invalidData
    }
    
    private static let templates: [Configuration.TemplateMetadata.TemplateType: Template] = [
        .containerStruct: ContainerStructTemplate(),
        .protocolExtension: ProtocolExtensionTemplate()
    ]
    
    static func main() async throws {
        guard CommandLine.arguments.count == 2 else {
            throw CodeGenerationError.invalidArguments
        }
        
        let configurationURL: URL = Bundle.module.url(forResource: "Resources/config", withExtension: "yml")!
        let configuration = try YAMLDecoder().decode(Configuration.self, from: try .init(contentsOf: configurationURL))
        let output = URL(filePath: CommandLine.arguments[1])
        
        try configuration.templates
            .flatMap { templateMetadata in
                guard let template = templates[templateMetadata.type] else {
                    return Array<(String, String)>()
                }
                
                return try templateMetadata.applyOn
                    .compactMap(configuration.get(structMetadata:))
                    .map { try template.generate(templateMetadata.name, for: $0, with: configuration) }
            }
            .forEach { (entry: (name: String, contents: String)) in
                guard let data = entry.contents.data(using: .utf8) else {
                    throw CodeGenerationError.invalidData
                }
                try data.write(to: output.appending(component: entry.name), options: .atomic)
            }
    }
}
