import 'package:json_annotation/json_annotation.dart';

part 'SwappingCurrencyListData.g.dart';

@JsonSerializable()
class SwappingCurrencyListData {

  @JsonKey(name: "fromTechnologyId")
  int? fromTechnologyId;
  @JsonKey(name: "fromCurrId")
  int? fromCurrId;
  @JsonKey(name: "symbol")
  String? symbol;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "fromImageUrl")
  String? fromImageUrl;
  @JsonKey(name: "toCurrency")
  List<SwappingCurrencyListData>? toCurrency;
  @JsonKey(name: "toTechnologyId")
  int? toTechnologyId;
  @JsonKey(name: "toCurrId")
  int? toCurrId;
  @JsonKey(name: "toImageUrl")
  String? toImageUrl;
  @JsonKey(name: "rate")
  double? rate;


  SwappingCurrencyListData(
      {this.fromTechnologyId,
      this.fromCurrId,
      this.symbol,
      this.name,
      this.fromImageUrl,
      this.toCurrency,
      this.toTechnologyId,
      this.toCurrId,
      this.toImageUrl,
      this.rate});

  factory SwappingCurrencyListData.fromJson(Map<String, dynamic> json) =>
      _$SwappingCurrencyListDataFromJson(json);

  Map<String, dynamic> toJson() => _$SwappingCurrencyListDataToJson(this);
}
