import Foundation

/// - TODO: headerdoc
public protocol Span {
    func context() -> SpanContext
    func tracer() -> Tracer
    func setOperationName(_ operationName: String)
    func setTag(key: String, value: Any)
    func log(fields: [String: Any], timestamp: Date?)
    func setBaggageItem(key: String, value: String)
    func baggageItem(withKey key: String) -> String?
    func finish(at time: Date?)
}

/// - TODO: headerdoc
public extension Span {
    func log(fields: [String: Any]) {
        self.log(fields: fields, timestamp: nil)
    }

    func finish() {
        self.finish(at: nil)
    }
}
