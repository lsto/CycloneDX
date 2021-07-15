import PackageModel
import PackageLoading
import PackageGraph
import Workspace

import CycloneDX
import Git

import Foundation
import struct Foundation.URL
import CryptoKit

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
let package = AbsolutePath("/Users/mattt/code/GitHub/example-package-dealer")

let repository = try? Repository.discover(at: URL(fileURLWithPath: package.pathString))

let diagnostics = DiagnosticsEngine()
let manifest = try ManifestLoader.loadManifest(packagePath: package, swiftCompiler: swiftCompiler, swiftCompilerFlags: [], packageKind: .local)
let loadedPackage = try PackageBuilder.loadPackage(packagePath: package, swiftCompiler: swiftCompiler, swiftCompilerFlags: [], diagnostics: diagnostics)
let graph = try Workspace.loadGraph(packagePath: package, swiftCompiler: swiftCompiler, swiftCompilerFlags: [], diagnostics: diagnostics)


var bom = BillOfMaterials(version: 1)

//print(graph.reachableTargets.map { t in t.dependencies.map { $0.description }})

var licenses: [License] = []

do {
    for file in try FileManager.default.contentsOfDirectory(at: package.asURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]) {
        guard file.lastPathComponent.localizedCaseInsensitiveContains("license"),
              let text = try? String(contentsOf: file)
        else { continue }

        licenses.append(.license(name: file.lastPathComponent, text: text))
    }
}


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
    component.licenses = licenses

    // TODO
    if let head = repository?.head?.commit {
        var commit = CycloneDX.Commit(id: head.id.description)
        commit.author = IdentifiableAction(timestamp: head.author.time, name: head.author.name, email: head.author.email)
        commit.committer = IdentifiableAction(timestamp: head.committer.time, name: head.committer.name, email: head.committer.email)
        commit.message = head.message?.trimmingCharacters(in: .whitespacesAndNewlines)
        component.pedigree = Pedigree(commits: [commit])
    }

    do {
        var filesByPath: [RelativePath: Component] = [:]
        for path in Set(product.targets.flatMap { $0.sources.paths }) {
            let relativePath = path.relative(to: package)
            var file = Component(id: relativePath.description, classification: .file)

            file.mimeType = path.preferredMIMEType

            file.hashes = [
                Hash(algorithm: "sha256", value: try SHA256.checksum(path)),
                Hash(algorithm: "sha384", value: try SHA384.checksum(path)),
                Hash(algorithm: "sha512", value: try SHA512.checksum(path))
            ]

            filesByPath[relativePath] = file
        }

        // TODO: Get last commit for a file
//        if let revisions = try repository?.revisions(with: { walker in
//            try walker.pushHead()
//            try walker.sort(with: .reverse)
//        }) {
//            for revision in revisions {
//                revision.
//            }
//        }

//        if let entries = repository?.index?.entries {
//            for entry in entries {
//                guard let path = try? RelativePath(validating: entry.path),
//                      var file = filesByPath[path]
//                else { continue }
//
//                let commit = CycloneDX.Commit(id: entry.)
//                file.pedigree = Pedigree(commits: [commit])
//
//                filesByPath[path] = file
//            }
//        }

        component.components.append(contentsOf: filesByPath.values)

    }

    bom.components.append(component)
}

//for package in graph.inputPackages where !graph.isRootPackage(package) {
//    var component = Component(id: package.name, classification: .library)
//    package.
//}

for dependency in graph.requiredDependencies where dependency.kind == .remote {
    var component = Component(id: dependency.name, classification: .library)

    do {
        guard let url = URL(string: dependency.repository.url) else { break }
        let reference = ExternalReference(kind: .vcs, url: url)
        component.externalReferences.append(reference)
    }

    bom.components.append(component)
}

fileprivate extension Dependency {
    init(_ package: ResolvedPackage) {
        self.init(reference: package.name, dependsOn: package.dependencies.map(Dependency.init))
    }
}

for package in graph.inputPackages {//} where !graph.isRootPackage(package) {

//    if let component = bom.components.first(where: { $0.classification == .library && $0.id == package.name }) {
        bom.dependencies.append(Dependency(package))
//    }
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
