import struct Foundation.URL

public enum LicenseChoice: Hashable, Encodable {
    case license(License)
    case expression(String)
}

public struct License: Identifiable, Hashable, Encodable {
    public enum ID: Hashable, Encodable {
        case other(String)
    }

    public var id: ID
    public var text: String?
    public var url: URL?
}
