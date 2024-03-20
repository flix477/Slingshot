struct Configuration: Decodable {
    let protocols: [ProtocolMetadata]
    let structs: [StructMetadata]
    let templates: [TemplateMetadata]
    
    struct TemplateMetadata: Decodable {
        enum TemplateType: String, Decodable {
            case containerStruct, protocolExtension
        }
        
        let name: String
        let applyOn: [String]
        let type: TemplateType
    }
    
    struct StructMetadata: Decodable {
        enum StructType: String, Decodable {
            case generic
            case concrete
        }
        
        struct Conformance: Decodable {
            let name: String
            let `where`: String?
        }
        
        let name: String
        let type: StructType
        let arguments: [String]?
        let elements: String?
        let conformances: [Conformance]
    }
    
    func get(structMetadata: String) -> StructMetadata? {
        structs.first(where: { $0.name == structMetadata })
    }
    
    func get(protocolMetadata: String) -> ProtocolMetadata? {
        protocols.first(where: { $0.name == protocolMetadata })
    }
    
    func get(templateMetadata: String) -> TemplateMetadata? {
        templates.first(where: { $0.name == templateMetadata })
    }
}
