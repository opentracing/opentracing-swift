public struct OpenTracing {
    private init() {}

    public static var shared: Tracer = NoopTracer()
}
