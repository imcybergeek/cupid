// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.info,
    required this.item,
    required this.event,
    required this.variable,
  });

  Info info;
  List<Item> item;
  List<Event> event;
  List<Variable> variable;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        info: Info.fromJson(json["info"]),
        item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
        event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
        variable: List<Variable>.from(
            json["variable"].map((x) => Variable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "item": List<dynamic>.from(item.map((x) => x.toJson())),
        "event": List<dynamic>.from(event.map((x) => x.toJson())),
        "variable": List<dynamic>.from(variable.map((x) => x.toJson())),
      };
}

class Event {
  Event({
    required this.listen,
    required this.script,
  });

  String listen;
  Script script;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        listen: json["listen"],
        script: Script.fromJson(json["script"]),
      );

  Map<String, dynamic> toJson() => {
        "listen": listen,
        "script": script.toJson(),
      };
}

class Script {
  Script({
    required this.type,
    required this.exec,
  });

  String type;
  List<String> exec;

  factory Script.fromJson(Map<String, dynamic> json) => Script(
        type: json["type"],
        exec: List<String>.from(json["exec"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "exec": List<dynamic>.from(exec.map((x) => x)),
      };
}

class Info {
  Info({
    required this.postmanId,
    required this.name,
    required this.schema,
  });

  String postmanId;
  String name;
  String schema;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        postmanId: json["_postman_id"],
        name: json["name"],
        schema: json["schema"],
      );

  Map<String, dynamic> toJson() => {
        "_postman_id": postmanId,
        "name": name,
        "schema": schema,
      };
}

class Item {
  Item({
    required this.name,
    required this.event,
    required this.request,
    required this.response,
  });

  String name;
  List<Event> event;
  Request request;
  List<Response> response;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        event: json["event"] == null
            ? null!
            : List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
        request: Request.fromJson(json["request"]),
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "event": event == null
            ? null
            : List<dynamic>.from(event.map((x) => x.toJson())),
        "request": request.toJson(),
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Request {
  Request({
    required this.method,
    required this.header,
    required this.body,
    required this.url,
    required this.auth,
    required this.description,
  });

  String method;
  List<dynamic> header;
  Body body;
  Url url;
  Auth auth;
  String description;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        method: json["method"],
        header: List<dynamic>.from(json["header"].map((x) => x)),
        body: Body.fromJson(json["body"]),
        url: Url.fromJson(json["url"]),
        auth: json["auth"] == null ? null! : Auth.fromJson(json["auth"]),
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "header": List<dynamic>.from(header.map((x) => x)),
        "body": body.toJson(),
        "url": url.toJson(),
        "auth": auth == null ? null : auth.toJson(),
        "description": description == null ? null : description,
      };
}

class Auth {
  Auth({
    required this.type,
    required this.bearer,
  });

  String type;
  List<Variable> bearer;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        type: json["type"],
        bearer: List<Variable>.from(
            json["bearer"].map((x) => Variable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "bearer": List<dynamic>.from(bearer.map((x) => x.toJson())),
      };
}

class Variable {
  Variable({
    required this.key,
    required this.value,
    required this.type,
  });

  String key;
  String value;
  Type type;

  factory Variable.fromJson(Map<String, dynamic> json) => Variable(
        key: json["key"],
        value: json["value"],
        type: typeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "type": typeValues.reverse[type],
      };
}

enum Type { STRING, TEXT }

final typeValues = EnumValues({"string": Type.STRING, "text": Type.TEXT});

class Body {
  Body({
    required this.mode,
    required this.urlencoded,
  });

  String mode;
  List<Variable> urlencoded;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        mode: json["mode"],
        urlencoded: List<Variable>.from(
            json["urlencoded"].map((x) => Variable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "urlencoded": List<dynamic>.from(urlencoded.map((x) => x.toJson())),
      };
}

class Url {
  Url({
    required this.raw,
    required this.host,
  });

  String raw;
  List<String> host;

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        raw: json["raw"],
        host: List<String>.from(json["host"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "host": List<dynamic>.from(host.map((x) => x)),
      };
}

class Response {
  Response({
    required this.name,
    required this.originalRequest,
    required this.status,
    required this.code,
    required this.postmanPreviewlanguage,
    required this.header,
    required this.cookie,
    required this.body,
  });

  String name;
  OriginalRequest originalRequest;
  String status;
  int code;
  String postmanPreviewlanguage;
  List<Header> header;
  List<dynamic> cookie;
  String body;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        name: json["name"],
        originalRequest: OriginalRequest.fromJson(json["originalRequest"]),
        status: json["status"],
        code: json["code"],
        postmanPreviewlanguage: json["_postman_previewlanguage"],
        header:
            List<Header>.from(json["header"].map((x) => Header.fromJson(x))),
        cookie: List<dynamic>.from(json["cookie"].map((x) => x)),
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "originalRequest": originalRequest.toJson(),
        "status": status,
        "code": code,
        "_postman_previewlanguage": postmanPreviewlanguage,
        "header": List<dynamic>.from(header.map((x) => x.toJson())),
        "cookie": List<dynamic>.from(cookie.map((x) => x)),
        "body": body,
      };
}

class Header {
  Header({
    required this.key,
    required this.value,
  });

  String key;
  String value;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class OriginalRequest {
  OriginalRequest({
    required this.method,
    required this.header,
    required this.body,
    required this.url,
  });

  String method;
  List<dynamic> header;
  Body body;
  Url url;

  factory OriginalRequest.fromJson(Map<String, dynamic> json) =>
      OriginalRequest(
        method: json["method"],
        header: List<dynamic>.from(json["header"].map((x) => x)),
        body: Body.fromJson(json["body"]),
        url: Url.fromJson(json["url"]),
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "header": List<dynamic>.from(header.map((x) => x)),
        "body": body.toJson(),
        "url": url.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
