import struct Foundation.URL

public struct Commit: Hashable, Identifiable, Encodable {
    public var id: String?
    public var url: URL?
    public var author: IdentifiableAction?
    public var committer: IdentifiableAction?
    public var message: String?

    public init(id: String? = nil, 
                url: URL? = nil, 
                author: IdentifiableAction? = nil, 
                committer: IdentifiableAction? = nil, 
                message: String? = nil) 
    {
        self.id = id
        self.url = url
        self.author = author
        self.committer = committer
        self.message = message
    }
}
