// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'get_to_dos.dart';

class GetToDosQueryMapper extends ClassMapperBase<GetToDosQuery> {
  GetToDosQueryMapper._();

  static GetToDosQueryMapper? _instance;
  static GetToDosQueryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GetToDosQueryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GetToDosQuery';

  static bool _$showOnlyCompleted(GetToDosQuery v) => v.showOnlyCompleted;
  static const Field<GetToDosQuery, bool> _f$showOnlyCompleted =
      Field('showOnlyCompleted', _$showOnlyCompleted);

  @override
  final MappableFields<GetToDosQuery> fields = const {
    #showOnlyCompleted: _f$showOnlyCompleted,
  };

  static GetToDosQuery _instantiate(DecodingData data) {
    return GetToDosQuery(showOnlyCompleted: data.dec(_f$showOnlyCompleted));
  }

  @override
  final Function instantiate = _instantiate;

  static GetToDosQuery fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GetToDosQuery>(map);
  }

  static GetToDosQuery fromJson(String json) {
    return ensureInitialized().decodeJson<GetToDosQuery>(json);
  }
}

mixin GetToDosQueryMappable {
  String toJson() {
    return GetToDosQueryMapper.ensureInitialized()
        .encodeJson<GetToDosQuery>(this as GetToDosQuery);
  }

  Map<String, dynamic> toMap() {
    return GetToDosQueryMapper.ensureInitialized()
        .encodeMap<GetToDosQuery>(this as GetToDosQuery);
  }

  GetToDosQueryCopyWith<GetToDosQuery, GetToDosQuery, GetToDosQuery>
      get copyWith => _GetToDosQueryCopyWithImpl(
          this as GetToDosQuery, $identity, $identity);
  @override
  String toString() {
    return GetToDosQueryMapper.ensureInitialized()
        .stringifyValue(this as GetToDosQuery);
  }

  @override
  bool operator ==(Object other) {
    return GetToDosQueryMapper.ensureInitialized()
        .equalsValue(this as GetToDosQuery, other);
  }

  @override
  int get hashCode {
    return GetToDosQueryMapper.ensureInitialized()
        .hashValue(this as GetToDosQuery);
  }
}

extension GetToDosQueryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GetToDosQuery, $Out> {
  GetToDosQueryCopyWith<$R, GetToDosQuery, $Out> get $asGetToDosQuery =>
      $base.as((v, t, t2) => _GetToDosQueryCopyWithImpl(v, t, t2));
}

abstract class GetToDosQueryCopyWith<$R, $In extends GetToDosQuery, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? showOnlyCompleted});
  GetToDosQueryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _GetToDosQueryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GetToDosQuery, $Out>
    implements GetToDosQueryCopyWith<$R, GetToDosQuery, $Out> {
  _GetToDosQueryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GetToDosQuery> $mapper =
      GetToDosQueryMapper.ensureInitialized();
  @override
  $R call({bool? showOnlyCompleted}) => $apply(FieldCopyWithData(
      {if (showOnlyCompleted != null) #showOnlyCompleted: showOnlyCompleted}));
  @override
  GetToDosQuery $make(CopyWithData data) => GetToDosQuery(
      showOnlyCompleted:
          data.get(#showOnlyCompleted, or: $value.showOnlyCompleted));

  @override
  GetToDosQueryCopyWith<$R2, GetToDosQuery, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GetToDosQueryCopyWithImpl($value, $cast, t);
}
