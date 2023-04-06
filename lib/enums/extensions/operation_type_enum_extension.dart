import 'package:estok_app/enums/operation_type_enum.dart';

extension OperationTypeEnumExtension on OperationTypeEnum {
  String get stringValue {
    switch (this) {
      case OperationTypeEnum.ATUALIZACAO:
        return "ATUALIZAÇÃO";
      case OperationTypeEnum.INSERCAO:
        return "INSERÇÃO";
      case OperationTypeEnum.REMOCAO:
        return "REMOÇÃO";
      default:
        return "";
    }
  }
}
