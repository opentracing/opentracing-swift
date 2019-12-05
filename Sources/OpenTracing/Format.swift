import Foundation

/// "Format", "Carrier", "Extract", "Inject", and "Text Map" are opentracing-specific concepts. See:
/// https://github.com/opentracing/specification/blob/master/specification.md#inject-a-spancontext-into-a-carrier
/// https://github.com/opentracing/specification/blob/master/specification.md#extract-a-spancontext-from-a-carrier
/// https://github.com/opentracing/specification/blob/master/specification.md#note-required-formats-for-injection-and-extraction

/// Format and carrier for extract().
/// A FormatReader is used to extract a SpanContext from a carrier.
/// The type of the child protocol is the format descriptor.
/// The carrier is specified by the protocol's return type for the getter, usually `getAll()`.
///
/// Marker protocol.
public protocol FormatReader: CustomFormatReader {}

/// Format and carrier for inject().
/// A FormatWriter is used to inject a SpanContext into a carrier.
/// The type of the child protocol is the format descriptor.
/// The carrier is specified by the protocol's parameter type for the setter, usually `setAll()`
///
/// Marker protocol.
public protocol FormatWriter: CustomFormatWriter {}

/// Read interface for a textmap
public protocol TextMapReader: FormatReader {}

/// Write interface for a textmap
public protocol TextMapWriter: FormatWriter {}

/// Read interface for HTTP headers
public protocol HTTPHeadersReader: TextMapReader {}

/// Write interface for HTTP headers
public protocol HTTPHeadersWriter: TextMapWriter {}

/// Read interface for a custom carrier
public protocol CustomFormatReader {

    /// Extract a span context from the custom carrier
    ///
    /// - returns: extracted span context from the custom carrier, or nil on failure
    func extract() -> SpanContext?
}

/// Write interface for a custom carrier
public protocol CustomFormatWriter {

    /// Inject a span context into the custom carrier
    ///
    /// - parameter spanContext: context to inject into the custom carrier
    func inject(spanContext: SpanContext)
}
