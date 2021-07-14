import PackageModel
import PackageLoading
import PackageGraph
import Workspace

import CycloneDX

import Foundation

// PREREQUISITES
// ============

// We will need to know where the Swift compiler is.
let swiftCompiler: AbsolutePath = {
    let string: String
    #if os(macOS)
    string = try! Process.checkNonZeroExit(args: "xcrun", "--sdk", "macosx", "-f", "swiftc").spm_chomp()
    #else
    string = try! Process.checkNonZeroExit(args: "which", "swiftc").spm_chomp()
    #endif
    return AbsolutePath(string)
}()

// We need a package to work with.
// This assumes there is one in the current working directory:
let package = AbsolutePath("/Users/mattt/code/github/CycloneDX")

// LOADING
// =======

// Note:
// This simplified API has been added since 0.4.0 was released.
// See older revisions for examples that work with 0.4.0.

// There are several levels of information available.
// Each takes longer to load than the level above it, but provides more detail.
let diagnostics = DiagnosticsEngine()
let manifest = try ManifestLoader.loadManifest(packagePath: package, swiftCompiler: swiftCompiler, swiftCompilerFlags: [], packageKind: .local)
let loadedPackage = try PackageBuilder.loadPackage(packagePath: package, swiftCompiler: swiftCompiler, swiftCompilerFlags: [], diagnostics: diagnostics)
let graph = try Workspace.loadGraph(packagePath: package, swiftCompiler: swiftCompiler, swiftCompilerFlags: [], diagnostics: diagnostics)


var bom = BillOfMaterials(version: 1)

//print(graph.reachableTargets.map { t in t.dependencies.map { $0.description }})


for product in graph.reachableProducts {
    guard product.targets.allSatisfy(graph.isInRootPackages) else { continue }



    let classification: Component.Classification

    switch product.type {
    case .library:
        classification = .library
    case .executable:
        classification = .application
    case .test:
        continue
    }

    var component = Component(id: product.name, classification: classification)

    do {
        for path in Set(product.targets.flatMap { $0.sources.paths }.map { $0.relative(to: package) }) {
            var file = Component(id: path.description, classification: .file)

            switch path.extension {
            case "swift":
                file.mimeType = "text/x-swift"
            default:
                break
            }

            component.components.append(file)
        }
    }

    bom.components.append(component)
}

for dependency in graph.requiredDependencies where dependency.kind == .remote {
    var component = Component(id: dependency.name, classification: .library)

    do {
        guard let url = URL(string: dependency.repository.url) else { break }
        var reference = ExternalReference(kind: .vcs, url: url)
        component.externalReferences.append(reference)
    }

    bom.components.append(component)
}



//print(graph.requiredDependencies)

let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted]
encoder.dateEncodingStrategy = .iso8601
let data = try encoder.encode(bom)

let json = String(data: data, encoding: .utf8)!
print(json)

//// Manifest
//let products = manifest.products.map({ $0.name }).joined(separator: ", ")
//print("Products:", products)
//let targets = manifest.targets.map({ $0.name }).joined(separator: ", ")
//print("Targets:", targets)
//
//// Package
//let executables = loadedPackage.targets.filter({ $0.type == .executable }).map({ $0.name })
//print("Executable targets:", executables)
//
//// PackageGraph
//let numberOfFiles = graph.reachableTargets.reduce(0, { $0 + $1.sources.paths.count })
//print("Total number of source files (including dependencies):", numberOfFiles)
