import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:customerapp/core/constants.dart';
import 'package:customerapp/core/errors/base_error.dart';
import 'package:customerapp/core/errors/forbidden_error.dart';
import 'package:customerapp/core/errors/net_error.dart';
import 'package:customerapp/core/errors/unexpected_error.dart';

class FirebaseProvider {
  static Future<Either<BaseError, RES>> getFirebaseResult<RES>({
    @required Function0<Future<RES>> request,
  }) async {
    try {
      return right(await request());
    } catch (e, s) {
      log('.........................FIREBASE ERROR ......................\n${e.toString()}\n..............................................................',
          name: TAG);

      print(s);
      return left((e));
    }
  }
}
