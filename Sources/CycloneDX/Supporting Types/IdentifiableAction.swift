import struct Foundation.Date

public struct IdentifiableAction: Hashable, Encodable {
    public var timestamp: Date?
    public var name: String?
    public var email: String?

    public init(timestamp: Date? = nil,
                name: String? = nil,
                email: String? = nil)
    {
        self.timestamp = timestamp
        self.name = name
        self.email = email
    }
}
