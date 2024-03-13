protocol Template {
    func generate(_ templateName: String,
                  for type: Configuration.StructMetadata,
                  with configuration: Configuration) throws -> (name: String, contents: String)
}
