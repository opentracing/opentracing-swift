public struct Reference {
    public let type: ReferenceType
    public let context: SpanContext

    static func child(of parent: SpanContext) -> Reference {
        return Reference(type: .childOf, context: parent)
    }

    static func follows(from precedingContext: SpanContext) -> Reference {
        return Reference(type: .followsFrom, context: precedingContext)
    }
}

public struct ReferenceType: RawRepresentable {
    public let rawValue: String
    public init(rawValue: String) { self.rawValue = rawValue }
    public init(_ rawValue: String) { self.rawValue = rawValue }

    public static let childOf = ReferenceType("CHILD_OF")
    public static let followsFrom = ReferenceType("FOLLOWS_FROM")
}
