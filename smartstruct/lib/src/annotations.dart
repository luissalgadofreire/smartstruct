/// Main Mapper Annotation.
///
/// Annotate your interface with [mapper], and run your build_runner to generate an implemented mapperclass of this interface.
class Mapper {
  final bool useInjection;
  final bool caseSensitiveFields;
  final bool static;

  const Mapper({this.useInjection = false, this.caseSensitiveFields = false, this.static = false});
}

const mapper = Mapper();

/// Mapping Annotation to support explicit field mapping in case the mapped source and target attribute do not match in name
///
/// Annotate the method with [Mapping] and provide a valid source and target fieldname to map these two fields with each other
class Mapping {
  final dynamic source;
  final String target;
  final bool ignore;
  const Mapping({required this.target, this.source, this.ignore = false});
}
