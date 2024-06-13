import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/models/response/edit_profile_response_model.dart';
import 'package:entrance_test/src/models/response/login_response_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/endpoint.dart';
import '../models/response/user_response_model.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;

  UserRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  Future<Either<String, String?>> login({
    required String phoneNumber,
    required String password,
    required String countryCode,
  }) async {
    try {
      final responseJson = await _client.post(
        Endpoint.login,
        data: {
          "phone_number": phoneNumber,
          "password": password,
          "country_code": countryCode,
        },
      );

      if (responseJson.statusCode == HttpStatus.ok) {
        final model = LoginResponseModel.fromJson(responseJson.data);
        return Right(model.data?.token);
      } else {
        return Left(NetworkingUtil.errorMessage(responseJson.data));
      }
    } on DioException catch (e) {
      return Left(e.message ?? 'Unknown Error');
    }
  }

  Future<Either<String, void>> logout() async {
    try {
      final responseJson = await _client.post(
        Endpoint.logout,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      if (responseJson.statusCode == HttpStatus.ok) {
        await _local.remove(LocalDataKey.token);
        return const Right(null);
      } else {
        return Left(NetworkingUtil.errorMessage(responseJson.data));
      }
    } on DioException catch (e) {
      return Left(e.message ?? 'Unknown Error');
    }
  }

  Future<void> downloadFileFromUrl() async {
    await _client.download(
      'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf',
      '${(await getTemporaryDirectory()).path}flutter_tutorial.pdf',
      onReceiveProgress: (recivedBytes, totalBytes) {},
      deleteOnError: true,
    );
  }

  Future<UserResponseModel> getUser() async {
    try {
      final responseJson = await _client.get(
        Endpoint.getUser,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      final model = UserResponseModel.fromJson(responseJson.data);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Either<String, EditProfileModel>> editProfile({
    required String name,
    required String email,
    required String gender,
    required String dateOfBirth,
    required String height,
    required String weight,
    required String picturePath,
  }) async {
    try {
      final responseJson = await _client.post(Endpoint.editUser,
          options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}',
            otherOptions: Options(contentType: 'multipart/form-data'),
          ),
          data: FormData.fromMap({
            "name": name,
            "email": email,
            "gender": gender,
            "date_of_birth": dateOfBirth,
            "height": height,
            "weight": weight,
            "profile_picture": picturePath.isNotEmpty
                ? await MultipartFile.fromFile(picturePath)
                : null,
            "_method": "PUT",
          }));
      if (responseJson.statusCode == HttpStatus.ok) {
        final model = EditProfileModel.fromJson(responseJson.data);
        return Right(model);
      } else {
        return Left(NetworkingUtil.errorMessage(responseJson.data));
      }
    } on DioException catch (e) {
      return Left(e.message ?? 'Unknown Error');
    }
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  Future<void> testUnauthenticated() async {
    try {
      final realToken = _local.read<String?>(LocalDataKey.token);
      await _local.write(
          LocalDataKey.token, '619|kM5YBY5yM15KEuSmSMaEzlfv0lWs83r4cp4oty2T');
      getUser();
      //401 not caught as exception
      await _local.write(LocalDataKey.token, realToken);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
