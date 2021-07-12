import struct Foundation.URL

/// External references provide a way to document systems, sites, and 
/// information that may be relevant but which are not included with the BOM.
public struct ExternalReference: Hashable, Encodable {
    public enum Kind: String, Hashable, Encodable {
        case vcs
        case issueTracker = "issue-tracker"
        case website
        case advisories
        case bom
        case mailingList = "mailing-list"
        case social = "social"
        case chat
        case documentation
        case support
        case distribution
        case license
        case buildMeta = "build-meta"
        case buildSystem = "build-system"
        case other
    }

    public var kind: Kind
    public var url: URL
    public var comment: String?
    public var hashes: [Hash]

    public init(kind: Kind, 
                url: URL, 
                comment: String? = nil, 
                hashes: [Hash] = []) 
    {
        self.kind = kind
        self.url = url
        self.comment = comment
        self.hashes = hashes
    }
}
