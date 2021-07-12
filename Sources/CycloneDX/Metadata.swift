import Foundation

public struct Metadata {
    public var timestamp: Date?
    public var tools: [Tool]
    public var authors: [OrganizationalContact]
    public var component: Component?
    public var manufacture: OrganizationalContact?
    public var licenses: [LicenseChoice]
    public var properties: Properties

    public init(timestamp: Date? = nil,
                tools: [Tool] = [],
                authors: [OrganizationalContact] = [],
                component: Component? = nil,
                manufacture: OrganizationalContact? = nil,
                licenses: [LicenseChoice] = [],
                properties: Properties = [:])
    {
        self.timestamp = timestamp
        self.tools = tools
        self.authors = authors
        self.component = component
        self.manufacture = manufacture
        self.licenses = licenses
        self.properties = properties
    }
}
