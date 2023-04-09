import '../entity_type_enum.dart';

extension EntityTypeEnumExtension on EntityTypeEnum {
  String get stringValue {
    switch (this) {
      case EntityTypeEnum.ESTOQUE:
        return 'Estoque';
      case EntityTypeEnum.PRODUTO:
        return 'Produto';
      default:
        return '';
    }
  }
}