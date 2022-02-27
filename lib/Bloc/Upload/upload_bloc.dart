import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commers/Controller/AuthController.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadState());

  @override
  Stream<UploadState> mapEventToState(UploadEvent event) async* {
    if (event is UploadPictureEvent) {
      yield* _mapUploadPicture(event.picture);
    }
  }

  Stream<UploadState> _mapUploadPicture(String picture) async* {
    try {
      final secureStorage = FlutterSecureStorage();

      yield LoadingImageState();

      final resp = await authController.uploadPicture(picture: picture);
      await secureStorage.write(key: 'picture', value: resp.picture);

      await Future.delayed(Duration(seconds: 3));

      yield UploadSuccess();

      yield state.copyWith(picture: resp.picture);
    } catch (e) {
      yield FailureSaveImage(error: e.toString());
    }
  }
}
