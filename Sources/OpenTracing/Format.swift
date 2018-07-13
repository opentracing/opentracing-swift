import Foundation

/// Format and carrier for extract(). Marker protocol.
public protocol FormatReader {}

// Format and carrier for inject(). Marker protocol.
public protocol FormatWriter {}

public protocol TextMapReader: FormatReader {
    func getAll() -> [String: String]
}

public protocol TextMapWriter: FormatWriter {
    func setAll(textMap: [String: String])
}

public protocol HTTPHeadersReader: TextMapReader {}
public protocol HTTPHeadersWriter: TextMapWriter {}

public protocol CustomFormatReader {
    func extract() -> SpanContext
}

public protocol CustomFormatWriter {
    func inject(spanContext: SpanContext)
}
