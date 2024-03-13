import Foundation
import PackagePlugin

@main
struct SlingshotPlugin: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {
        let output = context.pluginWorkDirectory
        let files = ["Array+NonEmpty",
                     "Array+FunctorFromSequence",
                     "Array+FunctorExtensions",
                     "Set+NonEmpty",
                     "Set+FunctorFromSequence",
                     "Set+FunctorExtensions",
                     "String+NonEmpty",
                     "Dictionary+NonEmpty",
                     "Optional+FunctorExtensions"]
        
        return [
            .buildCommand(displayName: "Generate Code",
                          executable: try context.tool(named: "SlingshotCodeGeneration").path,
                          arguments: [output],
                          environment: [:],
                          inputFiles: [],
                          outputFiles: files.map { output.appending("\($0).swift") })
        ]
    }
}
