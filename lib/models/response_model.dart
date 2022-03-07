import 'dart:convert';

ResponseModel authResponseFromJson(String str) => ResponseModel.fromJson(json.decode(str));


class ResponseModel {
    ResponseModel({
        this.validationErrors,
        this.hasError,
        this.message,
        this.data,
    });

    List<ValidationError>? validationErrors;
    bool? hasError;
    String? message;
    dynamic data;

    factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        validationErrors: List<ValidationError>.from(json["ValidationErrors"].map((x) => ValidationError.fromJson(x))),
        hasError: json["HasError"],
        message: json["Message"],
        data: json["Data"],
    );

}

class ValidationError {
    ValidationError({
        this.key,
        this.value,
    });

    String? key;
    String? value;

    factory ValidationError.fromJson(Map<String, dynamic> json) => ValidationError(
        key: json["Key"],
        value: json["Value"],
    );
}
