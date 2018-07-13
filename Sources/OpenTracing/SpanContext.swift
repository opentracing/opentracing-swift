/// - TODO: headerdoc
public protocol SpanContext {
    func forEachBaggageItem(callback: (_ key: String, _ value: String) -> Bool)
}
