struct OpenTracing {
    private init() {}

    static var shared: Tracer = NoopTracer()
}
