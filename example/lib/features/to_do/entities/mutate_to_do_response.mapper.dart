// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'mutate_to_do_response.dart';

class MutateValidationErrorMapper extends EnumMapper<MutateValidationError> {
  MutateValidationErrorMapper._();

  static MutateValidationErrorMapper? _instance;
  static MutateValidationErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MutateValidationErrorMapper._());
    }
    return _instance!;
  }

  static MutateValidationError fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  MutateValidationError decode(dynamic value) {
    switch (value) {
      case 'deletedUncompleted':
        return MutateValidationError.deletedUncompleted;
      case 'noTitle':
        return MutateValidationError.noTitle;
      case 'noDescription':
        return MutateValidationError.noDescription;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(MutateValidationError self) {
    switch (self) {
      case MutateValidationError.deletedUncompleted:
        return 'deletedUncompleted';
      case MutateValidationError.noTitle:
        return 'noTitle';
      case MutateValidationError.noDescription:
        return 'noDescription';
    }
  }
}

extension MutateValidationErrorMapperExtension on MutateValidationError {
  String toValue() {
    MutateValidationErrorMapper.ensureInitialized();
    return MapperContainer.globals.toValue<MutateValidationError>(this)
        as String;
  }
}

class MutateToDoResponseMapper extends ClassMapperBase<MutateToDoResponse> {
  MutateToDoResponseMapper._();

  static MutateToDoResponseMapper? _instance;
  static MutateToDoResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MutateToDoResponseMapper._());
      SuccessMutateToDoResponseMapper.ensureInitialized();
      InvalidMutateToDoResponseMapper.ensureInitialized();
      ExceptionMutateToDoResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MutateToDoResponse';

  @override
  final MappableFields<MutateToDoResponse> fields = const {};

  static MutateToDoResponse _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('MutateToDoResponse');
  }

  @override
  final Function instantiate = _instantiate;

  static MutateToDoResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MutateToDoResponse>(map);
  }

  static MutateToDoResponse fromJson(String json) {
    return ensureInitialized().decodeJson<MutateToDoResponse>(json);
  }
}

mixin MutateToDoResponseMappable {
  String toJson();
  Map<String, dynamic> toMap();
  MutateToDoResponseCopyWith<MutateToDoResponse, MutateToDoResponse,
      MutateToDoResponse> get copyWith;
}

abstract class MutateToDoResponseCopyWith<$R, $In extends MutateToDoResponse,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  MutateToDoResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class SuccessMutateToDoResponseMapper
    extends ClassMapperBase<SuccessMutateToDoResponse> {
  SuccessMutateToDoResponseMapper._();

  static SuccessMutateToDoResponseMapper? _instance;
  static SuccessMutateToDoResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = SuccessMutateToDoResponseMapper._());
      MutateToDoResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SuccessMutateToDoResponse';

  @override
  final MappableFields<SuccessMutateToDoResponse> fields = const {};

  static SuccessMutateToDoResponse _instantiate(DecodingData data) {
    return SuccessMutateToDoResponse();
  }

  @override
  final Function instantiate = _instantiate;

  static SuccessMutateToDoResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SuccessMutateToDoResponse>(map);
  }

  static SuccessMutateToDoResponse fromJson(String json) {
    return ensureInitialized().decodeJson<SuccessMutateToDoResponse>(json);
  }
}

mixin SuccessMutateToDoResponseMappable {
  String toJson() {
    return SuccessMutateToDoResponseMapper.ensureInitialized()
        .encodeJson<SuccessMutateToDoResponse>(
            this as SuccessMutateToDoResponse);
  }

  Map<String, dynamic> toMap() {
    return SuccessMutateToDoResponseMapper.ensureInitialized()
        .encodeMap<SuccessMutateToDoResponse>(
            this as SuccessMutateToDoResponse);
  }

  SuccessMutateToDoResponseCopyWith<SuccessMutateToDoResponse,
          SuccessMutateToDoResponse, SuccessMutateToDoResponse>
      get copyWith => _SuccessMutateToDoResponseCopyWithImpl(
          this as SuccessMutateToDoResponse, $identity, $identity);
  @override
  String toString() {
    return SuccessMutateToDoResponseMapper.ensureInitialized()
        .stringifyValue(this as SuccessMutateToDoResponse);
  }

  @override
  bool operator ==(Object other) {
    return SuccessMutateToDoResponseMapper.ensureInitialized()
        .equalsValue(this as SuccessMutateToDoResponse, other);
  }

  @override
  int get hashCode {
    return SuccessMutateToDoResponseMapper.ensureInitialized()
        .hashValue(this as SuccessMutateToDoResponse);
  }
}

extension SuccessMutateToDoResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SuccessMutateToDoResponse, $Out> {
  SuccessMutateToDoResponseCopyWith<$R, SuccessMutateToDoResponse, $Out>
      get $asSuccessMutateToDoResponse => $base
          .as((v, t, t2) => _SuccessMutateToDoResponseCopyWithImpl(v, t, t2));
}

abstract class SuccessMutateToDoResponseCopyWith<
    $R,
    $In extends SuccessMutateToDoResponse,
    $Out> implements MutateToDoResponseCopyWith<$R, $In, $Out> {
  @override
  $R call();
  SuccessMutateToDoResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SuccessMutateToDoResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SuccessMutateToDoResponse, $Out>
    implements
        SuccessMutateToDoResponseCopyWith<$R, SuccessMutateToDoResponse, $Out> {
  _SuccessMutateToDoResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SuccessMutateToDoResponse> $mapper =
      SuccessMutateToDoResponseMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  SuccessMutateToDoResponse $make(CopyWithData data) =>
      SuccessMutateToDoResponse();

  @override
  SuccessMutateToDoResponseCopyWith<$R2, SuccessMutateToDoResponse, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SuccessMutateToDoResponseCopyWithImpl($value, $cast, t);
}

class InvalidMutateToDoResponseMapper
    extends ClassMapperBase<InvalidMutateToDoResponse> {
  InvalidMutateToDoResponseMapper._();

  static InvalidMutateToDoResponseMapper? _instance;
  static InvalidMutateToDoResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = InvalidMutateToDoResponseMapper._());
      MutateToDoResponseMapper.ensureInitialized();
      MutateValidationErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'InvalidMutateToDoResponse';

  static MutateValidationError _$reason(InvalidMutateToDoResponse v) =>
      v.reason;
  static const Field<InvalidMutateToDoResponse, MutateValidationError>
      _f$reason = Field('reason', _$reason);

  @override
  final MappableFields<InvalidMutateToDoResponse> fields = const {
    #reason: _f$reason,
  };

  static InvalidMutateToDoResponse _instantiate(DecodingData data) {
    return InvalidMutateToDoResponse(reason: data.dec(_f$reason));
  }

  @override
  final Function instantiate = _instantiate;

  static InvalidMutateToDoResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InvalidMutateToDoResponse>(map);
  }

  static InvalidMutateToDoResponse fromJson(String json) {
    return ensureInitialized().decodeJson<InvalidMutateToDoResponse>(json);
  }
}

mixin InvalidMutateToDoResponseMappable {
  String toJson() {
    return InvalidMutateToDoResponseMapper.ensureInitialized()
        .encodeJson<InvalidMutateToDoResponse>(
            this as InvalidMutateToDoResponse);
  }

  Map<String, dynamic> toMap() {
    return InvalidMutateToDoResponseMapper.ensureInitialized()
        .encodeMap<InvalidMutateToDoResponse>(
            this as InvalidMutateToDoResponse);
  }

  InvalidMutateToDoResponseCopyWith<InvalidMutateToDoResponse,
          InvalidMutateToDoResponse, InvalidMutateToDoResponse>
      get copyWith => _InvalidMutateToDoResponseCopyWithImpl(
          this as InvalidMutateToDoResponse, $identity, $identity);
  @override
  String toString() {
    return InvalidMutateToDoResponseMapper.ensureInitialized()
        .stringifyValue(this as InvalidMutateToDoResponse);
  }

  @override
  bool operator ==(Object other) {
    return InvalidMutateToDoResponseMapper.ensureInitialized()
        .equalsValue(this as InvalidMutateToDoResponse, other);
  }

  @override
  int get hashCode {
    return InvalidMutateToDoResponseMapper.ensureInitialized()
        .hashValue(this as InvalidMutateToDoResponse);
  }
}

extension InvalidMutateToDoResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InvalidMutateToDoResponse, $Out> {
  InvalidMutateToDoResponseCopyWith<$R, InvalidMutateToDoResponse, $Out>
      get $asInvalidMutateToDoResponse => $base
          .as((v, t, t2) => _InvalidMutateToDoResponseCopyWithImpl(v, t, t2));
}

abstract class InvalidMutateToDoResponseCopyWith<
    $R,
    $In extends InvalidMutateToDoResponse,
    $Out> implements MutateToDoResponseCopyWith<$R, $In, $Out> {
  @override
  $R call({MutateValidationError? reason});
  InvalidMutateToDoResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _InvalidMutateToDoResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InvalidMutateToDoResponse, $Out>
    implements
        InvalidMutateToDoResponseCopyWith<$R, InvalidMutateToDoResponse, $Out> {
  _InvalidMutateToDoResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InvalidMutateToDoResponse> $mapper =
      InvalidMutateToDoResponseMapper.ensureInitialized();
  @override
  $R call({MutateValidationError? reason}) =>
      $apply(FieldCopyWithData({if (reason != null) #reason: reason}));
  @override
  InvalidMutateToDoResponse $make(CopyWithData data) =>
      InvalidMutateToDoResponse(reason: data.get(#reason, or: $value.reason));

  @override
  InvalidMutateToDoResponseCopyWith<$R2, InvalidMutateToDoResponse, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _InvalidMutateToDoResponseCopyWithImpl($value, $cast, t);
}

class ExceptionMutateToDoResponseMapper
    extends ClassMapperBase<ExceptionMutateToDoResponse> {
  ExceptionMutateToDoResponseMapper._();

  static ExceptionMutateToDoResponseMapper? _instance;
  static ExceptionMutateToDoResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = ExceptionMutateToDoResponseMapper._());
      MutateToDoResponseMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ExceptionMutateToDoResponse';

  static Exception _$exception(ExceptionMutateToDoResponse v) => v.exception;
  static const Field<ExceptionMutateToDoResponse, Exception> _f$exception =
      Field('exception', _$exception);
  static StackTrace _$stackTrace(ExceptionMutateToDoResponse v) => v.stackTrace;
  static const Field<ExceptionMutateToDoResponse, StackTrace> _f$stackTrace =
      Field('stackTrace', _$stackTrace);

  @override
  final MappableFields<ExceptionMutateToDoResponse> fields = const {
    #exception: _f$exception,
    #stackTrace: _f$stackTrace,
  };

  static ExceptionMutateToDoResponse _instantiate(DecodingData data) {
    return ExceptionMutateToDoResponse(
        data.dec(_f$exception), data.dec(_f$stackTrace));
  }

  @override
  final Function instantiate = _instantiate;

  static ExceptionMutateToDoResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ExceptionMutateToDoResponse>(map);
  }

  static ExceptionMutateToDoResponse fromJson(String json) {
    return ensureInitialized().decodeJson<ExceptionMutateToDoResponse>(json);
  }
}

mixin ExceptionMutateToDoResponseMappable {
  String toJson() {
    return ExceptionMutateToDoResponseMapper.ensureInitialized()
        .encodeJson<ExceptionMutateToDoResponse>(
            this as ExceptionMutateToDoResponse);
  }

  Map<String, dynamic> toMap() {
    return ExceptionMutateToDoResponseMapper.ensureInitialized()
        .encodeMap<ExceptionMutateToDoResponse>(
            this as ExceptionMutateToDoResponse);
  }

  ExceptionMutateToDoResponseCopyWith<ExceptionMutateToDoResponse,
          ExceptionMutateToDoResponse, ExceptionMutateToDoResponse>
      get copyWith => _ExceptionMutateToDoResponseCopyWithImpl(
          this as ExceptionMutateToDoResponse, $identity, $identity);
  @override
  String toString() {
    return ExceptionMutateToDoResponseMapper.ensureInitialized()
        .stringifyValue(this as ExceptionMutateToDoResponse);
  }

  @override
  bool operator ==(Object other) {
    return ExceptionMutateToDoResponseMapper.ensureInitialized()
        .equalsValue(this as ExceptionMutateToDoResponse, other);
  }

  @override
  int get hashCode {
    return ExceptionMutateToDoResponseMapper.ensureInitialized()
        .hashValue(this as ExceptionMutateToDoResponse);
  }
}

extension ExceptionMutateToDoResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ExceptionMutateToDoResponse, $Out> {
  ExceptionMutateToDoResponseCopyWith<$R, ExceptionMutateToDoResponse, $Out>
      get $asExceptionMutateToDoResponse => $base
          .as((v, t, t2) => _ExceptionMutateToDoResponseCopyWithImpl(v, t, t2));
}

abstract class ExceptionMutateToDoResponseCopyWith<
    $R,
    $In extends ExceptionMutateToDoResponse,
    $Out> implements MutateToDoResponseCopyWith<$R, $In, $Out> {
  @override
  $R call({Exception? exception, StackTrace? stackTrace});
  ExceptionMutateToDoResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ExceptionMutateToDoResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ExceptionMutateToDoResponse, $Out>
    implements
        ExceptionMutateToDoResponseCopyWith<$R, ExceptionMutateToDoResponse,
            $Out> {
  _ExceptionMutateToDoResponseCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ExceptionMutateToDoResponse> $mapper =
      ExceptionMutateToDoResponseMapper.ensureInitialized();
  @override
  $R call({Exception? exception, StackTrace? stackTrace}) =>
      $apply(FieldCopyWithData({
        if (exception != null) #exception: exception,
        if (stackTrace != null) #stackTrace: stackTrace
      }));
  @override
  ExceptionMutateToDoResponse $make(CopyWithData data) =>
      ExceptionMutateToDoResponse(data.get(#exception, or: $value.exception),
          data.get(#stackTrace, or: $value.stackTrace));

  @override
  ExceptionMutateToDoResponseCopyWith<$R2, ExceptionMutateToDoResponse, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ExceptionMutateToDoResponseCopyWithImpl($value, $cast, t);
}
