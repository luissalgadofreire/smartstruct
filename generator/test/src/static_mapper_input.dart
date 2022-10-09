part of 'mapper_test_input.dart';

enum StaticEnumTarget {
  ONE,TWO,THREE
}

class StaticMappingTarget {
  final String text;
  final num number;
  final StaticEnumTarget foo;

  StaticMappingTarget(this.text, this.number, this.foo);
}

class StaticMappingSource {
  final String text;
  final num number;

  StaticMappingSource(this.text, this.number);
}

@Mapper()
@ShouldGenerate(r'''
class StaticMappingMapperImpl extends StaticMappingMapper {
  StaticMappingMapperImpl() : super();

  @override
  StaticMappingTarget fromSourceNormal(StaticMappingSource source) {
    final staticmappingtarget = StaticMappingTarget(
      source.text,
      source.number,
    );
    return staticmappingtarget;
  }
}

StaticMappingTarget _$fromSourceStatic(StaticMappingSource source) {
  final staticmappingtarget = StaticMappingTarget(
    source.text,
    source.number,
    StaticMappingMapper.mapEnum(source),
  );
  return staticmappingtarget;
}
''')
abstract class StaticMappingMapper {
  // mapper for primitive types should never be generated by default
  static String ignoredPrimitiveTypeMethod() => "ignore me";
  // these helpers should not be generated as they are ignored by default
  static StaticEnumTarget mapEnum(StaticMappingSource source) => StaticEnumTarget.ONE;
  static List<StaticEnumTarget> mapEnumList(StaticMappingSource source) => [StaticEnumTarget.ONE, StaticEnumTarget.THREE];
  static Set<String> mapSomeSet(StaticMappingSource source) => {"1", "2"};

  // helper should be ignored as it is explicitly annotated
  @IgnoreMapping()
  static StaticMappingTarget? fromSourceStaticIgnored(StaticMappingSource source) => null;

  // this helper should be generated as it is explicitly configured to do so via the StaticMapping Annotation
  @Mapping(source: mapEnum, target: 'foo')
  static StaticMappingTarget fromSourceStatic(StaticMappingSource source) => _$fromSourceStatic(source);

  StaticMappingTarget fromSourceNormal(StaticMappingSource source);
}

// just so the test compiles
StaticMappingTarget _$fromSourceStatic(StaticMappingSource source) => StaticMappingTarget("text", 1, StaticEnumTarget.THREE);
