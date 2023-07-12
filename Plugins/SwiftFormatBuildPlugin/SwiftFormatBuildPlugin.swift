import Foundation
import PackagePlugin

//@main
//struct SwiftFormatBuildPlugin: XcodeCommandPlugin {
//    func performCommand(context: XcodeProjectPlugin.XcodePluginContext, arguments: [String]) throws {
//        //
//    }
//}
//#else
//@main
//struct SwiftFormatBuildPlugin: BuildToolPlugin {
//    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
//        return [
//            .buildCommand(
//                displayName: "Format code",
//                executable: try context.tool(named: "foo").path,
//                arguments: [])
//        ]
//    }
//}
//#endif

//#if swift(>=5.6)
//    #if canImport(XcodeProjectPlugin)
//        import XcodeProjectPlugin
//
//        extension SwiftFormatPlugin: XcodeCommandPlugin {
//            /// This entry point is called when operating on an Xcode project.
//            func performCommand(context: XcodePluginContext, arguments: [String]) throws {
//                if arguments.contains("--verbose") {
//                    print("Command plugin execution with arguments \(arguments.description) for Swift package \(context.xcodeProject.displayName). All target information: \(context.xcodeProject.targets.description)")
//                    print("Plugin will run for directory: \(context.xcodeProject.directory.description)")
//                }
//
//                var argExtractor = ArgumentExtractor(arguments)
//                _ = argExtractor.extractOption(named: "target")
//
//                try formatCode(in: context.xcodeProject.directory, context: context, arguments: argExtractor.remainingArguments)
//            }
//        }
//    #endif
//#endif

@main
struct SwiftFormatBuildPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
       return []
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftFormatBuildPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodeProjectPlugin.XcodePluginContext, target: XcodeProjectPlugin.XcodeTarget) throws -> [PackagePlugin.Command] {
        let executable = try context.tool(named: "CommandLineTool")

        let directory = context.xcodeProject.directory.string

        return [
            .prebuildCommand(
                displayName: "SwiftFormat format code plugin",
                executable: executable.path,
                arguments: [directory],
                outputFilesDirectory: context.pluginWorkDirectory)
        ]
    }
}
#endif
