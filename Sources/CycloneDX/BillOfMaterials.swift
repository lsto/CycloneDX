import struct Foundation.UUID

public struct BillOfMaterials {
    public typealias Reference = String

    public let format: String = "CycloneDX"

    public var version: Int?
    public var serialNumber: UUID?

    public var metadata: Metadata
    public var components: [Component]
    public var services: [Service]
    public var externalReferences: [ExternalReference]
    public var dependencies: [Dependency]
    public var compositions: [Composition]
    public var properties: Properties

    public init(version: Int? = nil,
                serialNumber: UUID? = nil,
                metadata: Metadata = Metadata(),
                components: [Component] = [],
                services: [Service] = [],
                externalReferences: [ExternalReference] = [],
                dependencies: [Dependency] = [],
                compositions: [Composition] = [],
                properties: Properties = [:]) 
    {
        self.version = version
        self.serialNumber = serialNumber
        self.metadata = metadata
        self.components = components
        self.services = services
        self.externalReferences = externalReferences
        self.dependencies = dependencies
        self.compositions = compositions
        self.properties = properties
    }
}

public typealias BOM = BillOfMaterials
