import 'package:fase2cleanarchitecture/domain/entities/product.dart';

class RatingModel {
  final double? rate;
  final int? count;

  RatingModel({
    this.rate,
    this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };

  Rating toEntity() {
    return Rating(
      rate: rate!,
      count: count!,
    );
  }
}
