public enum Creator: Hashable {
    case person(name: String, email: String?)
    case organization(name: String, email: String?)
    case tool(identifier: String, version: String)
}
