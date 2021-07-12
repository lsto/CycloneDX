public struct Component: Identifiable, Hashable, Encodable {
    public enum Classification: String, Hashable, Encodable {
        case application
        case framework
        case library
        case container
        case operatingSystem = "operating-system"
        case device
        case firmware
        case file
    }

    public enum Scope: String, Hashable, Encodable {
        case required
        case optional
        case excluded
    }

    public struct Evidence: Hashable, Encodable {
        public var licenses: LicenseChoice?
        public var copyright: Copyright?

        public init(licenses: LicenseChoice? = nil, 
                    copyright: Copyright? = nil) 
        {
            self.licenses = licenses
            self.copyright = copyright
        }
    }

    public var id: String
    public var classification: Classification
    public var mimeType: String

    public var supplier: OrganizationalEntity?
    public var author: String?
    public var publisher: String?
    public var group: String?
    public var version: String?
    public var description: String?
    public var scope: Scope?
    public var hashes: [Hash]
    public var licenses: [LicenseChoice]
    public var copyright: String?
    public var cpe: CPE?
    public var purl: String?
    public var modified: Bool?
    public var pedigree: Pedigree?
    public var externalReferences: [ExternalReference]
    public var properties: Properties
    public var components: [Component]
    public var evidence: [Evidence]

    public init(id: String,
                classification: Classification,
                mimeType: String,
                supplier: OrganizationalEntity? = nil,
                author: String? = nil,
                publisher: String? = nil,
                group: String? = nil,
                version: String? = nil,
                description: String? = nil,
                scope: Scope? = nil,
                hashes: [Hash] = [],
                licenses: [LicenseChoice] = [],
                copyright: String? = nil,
                cpe: CPE? = nil,
                purl: String? = nil,
                modified: Bool? = nil,
                pedigree: Pedigree? = nil,
                externalReferences: [ExternalReference] = [],
                properties: Properties = [:],
                components: [Component] = [],
                evidence: [Evidence] = []) 
    {
        self.id = id
        self.classification = classification
        self.mimeType = mimeType
        self.supplier = supplier
        self.author = author
        self.publisher = publisher
        self.group = group
        self.version = version
        self.description = description
        self.scope = scope
        self.hashes = hashes
        self.licenses = licenses
        self.copyright = copyright
        self.cpe = cpe
        self.purl = purl
        self.modified = modified
        self.pedigree = pedigree
        self.externalReferences = externalReferences
        self.properties = properties
        self.components = components
        self.evidence = evidence
    }
}
