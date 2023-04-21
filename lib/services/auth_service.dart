import 'dart:developer';
import 'package:dalog_distribution/helper/shared_preferance.dart';
import 'package:dalog_distribution/models/forgot_password.dart';
import 'package:dalog_distribution/models/login.dart';
import 'package:dalog_distribution/models/otp_recheck.dart';
import 'package:dalog_distribution/models/sign_up.dart';
import 'package:dalog_distribution/models/uploadImage.dart';
import 'package:dalog_distribution/models/verify_otp.dart';
import 'package:dalog_distribution/provider/user_id_provider.dart';
import 'package:dalog_distribution/routs/arguments.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/job_list_model.dart';
import '../models/response_model.dart';
import '../routs/app_routs.dart';
import '../utils/loder.dart';
import 'api_endpoints.dart';
import 'api_response_model.dart';
import 'dio_client.dart';
import 'exception.dart';
import 'function.dart';

class ApiService {
  ApiClient apiClient = ApiClient();

  Future signUp(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();

      ApiResponseModel? apiResponse =
          await apiClient.post(EndPoints.signUp, data: data);

      if (apiResponse != null) {
        if (apiResponse.success == true) {
          SignUp register = SignUp.fromJson(apiResponse.response);
          print('register --> ${register.toJson()}');
          log(register.toString());

          // await Provider.of<UserProvider>(context, listen: false)
          //     .setUser(currentUser: userRegisterModel);

          //SharedPreferences preferences = await SharedPreferences.getInstance();
          // preferences.setString("user", jsonEncode(userRegisterModel.toJson()));

          CommonFunctions.toast(apiResponse.message);

          Navigator.pushNamed(context, Routs.otp,
              arguments: OtpArguments(id: register.id, otp: register.otp));

          return register;
        } else {
          CommonFunctions.toast(apiResponse.message);
        }
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future verifyOtp(BuildContext context, {FormData? data, int? status}) async {
    try {
      Loader.showLoader();
      ApiResponseModel? apiResponse =
          await apiClient.post(EndPoints.verifyOtp, data: data);

      if (apiResponse != null) {
        if (apiResponse.success == true) {
          VerifyOtp otp = VerifyOtp.fromJson(apiResponse.response);

          print(otp.toJson());
          if (status == 1) {
            Preferances.setString("user", otp.toJson());
            Preferances.setString("userid", otp.id);

            await Provider.of<UserId>(context, listen: false)
                .setUserId(userid: otp.id);
            Navigator.pushNamedAndRemoveUntil(
                context, Routs.bottomNavigation, (route) => false);
          } else {
            Navigator.pushNamed(context, Routs.login);
          }

          return otp;
        } else {
          CommonFunctions.toast(apiResponse.message);
        }
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future resendOtp({FormData? data}) async {
    try {
      Loader.showLoader();
      ApiResponseModel? apiResponse =
          await apiClient.post(EndPoints.resendOtp, data: data);

      if (apiResponse != null) {
        if (apiResponse.success == true) {
          CommonFunctions.toast(apiResponse.message);

          return apiResponse;
        } else {
          CommonFunctions.toast(apiResponse.message);
        }
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future loginUser(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();
      ApiResponseModel? apiResponse =
          await apiClient.post(EndPoints.login, data: data);

      if (apiResponse != null) {
        if (apiResponse.success == true) {
          Login login = Login.fromJson(apiResponse.response);
          Preferances.setString("user", login.toJson());
          Preferances.setString("userid", login.id);
          //Preferances.setString("userToken", login.token);
          CommonFunctions.toast(apiResponse.message);
          await Provider.of<UserId>(context, listen: false)
              .setUserId(userid: login.id);
          Navigator.pushNamedAndRemoveUntil(
              context, Routs.bottomNavigation, (route) => false);

          //Navigator.pushNamed(context, Routs.bottomNavigation);

          return login;
        } else {
          CommonFunctions.toast(apiResponse.message);
        }
      }
    } on DioError catch (e) {
      print(e);
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      // CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future forgotPassword(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();
      ApiResponseModel? apiResponseModel =
          await apiClient.post(EndPoints.forgotPassword, data: data);

      if (apiResponseModel != null) {
        if (apiResponseModel.success == true) {
          ForgotPasswordModel forgotPasswordModel =
              ForgotPasswordModel.fromJson(apiResponseModel.response);

          CommonFunctions.toast(apiResponseModel.message);
          Navigator.pushNamed(context, Routs.otp,
              arguments: OtpArguments(
                  status: 1,
                  id: forgotPasswordModel.userId,
                  otp: forgotPasswordModel.userId));

          return forgotPasswordModel;
        } else {
          CommonFunctions.toast(apiResponseModel.message);
        }
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future otpVerifyResetPassword(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();
      ApiResponseModel? apiResponseModel =
          await apiClient.post(EndPoints.otpCheckResetPassword, data: data);

      if (apiResponseModel != null) {
        if (apiResponseModel.success == true) {
          OtpRecheck otpRecheck =
              OtpRecheck.fromJson(apiResponseModel.response);
          CommonFunctions.toast(apiResponseModel.message);
          Navigator.pushNamed(context, Routs.resetPassword,
              arguments: OtpArguments(
                id: otpRecheck.userId,
              ));
        } else {
          CommonFunctions.toast(apiResponseModel.message);
        }
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future resetPassword(BuildContext context, {FormData? data}) async {
    try {
      Loader.showLoader();

      ApiResponseModel? apiResponseModel =
          await apiClient.post(EndPoints.resetPassword, data: data);

      if (apiResponseModel != null) {
        if (apiResponseModel.success == true) {
          CommonFunctions.toast(apiResponseModel.message);
          //  Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
          Navigator.pushNamed(context, Routs.login);
          // return apiResponseModel;
        } else {
          CommonFunctions.toast(apiResponseModel.message);
        }
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future updateProfile(BuildContext context, {FormData? data}) async {
    //  String? apiToken = await Preferances.getString("userToken");
    print('data --> ${data!.fields.toString()}');
    try {
      Loader.showLoader();
      ApiResponseModel? apiResponseModel = await apiClient.post(
        EndPoints.updateProfile,
        data: data,
        //  options: Options(headers: {"Authorization": "Bearer$apiToken}"})
      );
      if (apiResponseModel != null) {
        if (apiResponseModel.success == true) {
          Login login = Login.fromJson(apiResponseModel.response);
          Preferances.setString("user", login.toJson());
          print('profile update --> ${login.toJson()}');
          CommonFunctions.toast(apiResponseModel.message);
          print(apiResponseModel.message);
        } else {
          CommonFunctions.toast(apiResponseModel.message);
        }
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('up eee ${e.toString()}');
      CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future changePassword(
      BuildContext context, String oldPassword, String newPassword) async {
    //String? apiToken = await Preferances.getString("userToken");
    String? userid = await Preferances.getString("userid");
    try {
      Loader.showLoader();
      FormData fd = FormData.fromMap({
        "user_id": userid!.replaceAll('"', '').replaceAll('"', '').toString(),
        "old_password": oldPassword,
        "new_password": newPassword
      });
      print('change paa --> ${fd.fields.toString()}');
      ApiResponseModel? apiResponseModel =
          await apiClient.post(EndPoints.changePassword,
              data: fd,
              options: Options(headers: {
                "Content-Type":
                    'application/json', /*"Authorization": "Bearer$apiToken"*/
              }));
      if (apiResponseModel != null) {
        if (apiResponseModel.success == true) {
          CommonFunctions.toast(apiResponseModel.message);
          // Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
          Navigator.pushNamed(context, Routs.login);
          // return apiResponseModel;
        } else {
          CommonFunctions.toast(apiResponseModel.message);
        }
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('eeeeeee ${e.toString()}');
      CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  Future uploadImage(BuildContext context, {FormData? data}) async {
    //String? apiToken = await Preferances.getString("userToken");

    try {
      Loader.showLoader();
      print("hello");
      ApiResponseModel? apiResponseModel = await apiClient.post(
        EndPoints.uploadImageUrl,
        data: data,
        // options: Options(headers: {"Authorization": "Bearer$apiToken"}
        // )
      );

      if (apiResponseModel != null) {
        if (apiResponseModel.success == true) {
          UploadImage uploadImage =
              UploadImage.fromJson(apiResponseModel.response);
          print(uploadImage.toString());
          return uploadImage;
        } else {
          log(apiResponseModel.response);
        }
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      CommonFunctions.toast(errorMessage);
      return;
    } finally {
      Loader.hideLoader();
    }
  }

  //Dio dio = Dio();
  // Future createJob(BuildContext context, {FormData? data}) async {
  //   try {
  //     Loader.showLoader();
  //
  //     // FormData formData1 = FormData.fromMap({
  //     //   'user_id':'63521a7bf68dafe14c09346a',
  //     //   'job_tittle':'gfdgd',
  //     //   'pickup_location':'vesu near xyz',
  //     //   'pickup_date':'Nov 17, 2022',
  //     //   'pickup_time':'02: 25',
  //     //   'pickup_address':'fgdfg',
  //     //   'pickup_address2':'fgfd',
  //     //   'pickup_city':'fgfd',
  //     //   'pickup_state':'fgf',
  //     //   'pickup_zipcode':'6565',
  //     //   'pickup_country':'fdfs',
  //     //   'address':'hfgf',
  //     //   'address2':'ghf',
  //     //   'city':'hfg',
  //     //   'state':'hf',
  //     //   'zipcode':'2666',
  //     //   'country':'fhhfg',
  //     //   'special_instructions':'dfgdgdf',
  //     //   'dropoffdate':'Nov 17, 2022',
  //     //   'dropofftime':'05:23',
  //     //   'customize_item':'[{"key":"customize_item","value":"[{\"image\":\"1a432f5e64f29baf4dbfd69fc11944e8.png\",\"quantities\":\"2\",\"length\":\"2345\"}]","type":"text"}]',
  //     //   'item_name':'tes',
  //     //   'item_value':'34',
  //     //   'cost':'50',
  //     //   'service_fees':'100',
  //     //
  //     // });
  //     print('data --> ${data!.fields.toString()}');
  //     String? apiToken = await Preferances.getString("userToken");
  //     print('apiToken --> ${apiToken.toString()}');
  //     Response response;
  //     response = await dio.post("http://18.188.34.79:3000/api/job/createjob",
  //         //EndPoints.createJob,
  //         options: Options(headers: {
  //           "Content-Type": 'application/json',
  //           "Accept": "*/*",
  //           // "Accept-Encoding": 'gzip, deflate, br',
  //           //"Authorization": "Bearer ${apiToken.toString()}"
  //         }),
  //         data: data);
  //     if (response.statusCode == 200) {
  //       print('getVehicleDeliveryApi ----- > ${response.data}');
  //       //GetVehicleDeliveryModel responseData = GetVehicleDeliveryModel.fromJson(response.data);
  //
  //       // return responseData;
  //     } else {
  //       CommonFunctions.toast(response.statusMessage.toString());
  //     }
  //   } on DioError catch (e) {
  //     print('Dio E  ' + e.toString());
  //     //  throw handleError(e);
  //   } finally {
  //     Loader.hideLoader();
  //   }
  // }
  Future createJob(BuildContext context, {FormData? data}) async {
    //String? apiToken = await Preferances.getString("userToken");
    //print(apiToken);
    print('data --> ${data!.fields.toString()}');
    try {
      Loader.showLoader();
      ApiResponseModel? apiResponseModel = await apiClient.post(
        EndPoints.createjob,
        data: data,
        options: Options(headers: {
          "Content-Type": 'application/json',
          "Accept": "*/*",
          //   //"Authorization": "Bearer ${apiToken.toString()}"
        }),
      );

      print('apiResponseModel.success --> ${apiResponseModel!.statusCode}');
      if (apiResponseModel != null) {
        if (apiResponseModel.success == true) {
          CommonFunctions.toast(apiResponseModel.message);
          print(apiResponseModel.response);
          Navigator.pushNamed(context, Routs.bottomNavigation);
          print('message --> ${apiResponseModel.message}');
          return apiResponseModel;
        } else {
          print('message --> ${apiResponseModel.message}');
          CommonFunctions.toast(apiResponseModel.message);
        }
      }
    } on DioError catch (e) {
      print('Dio E  ' + e.toString());
      // throw handleError(e);
    } finally {
      Loader.hideLoader();
    }
  }

  Dio dio = Dio();

  Future<GetJobListModel?> getOpenJobList() async {
    try {
      String? userId1 = await Preferances.getString("userid");
      Loader.showLoader();
      Response response;
      FormData formData = FormData.fromMap({
        "user_id": userId1!.replaceAll('"', '').replaceAll('"', '').toString()
      });
      print('url --> ${EndPoints.myOpenJobList}');
      response = await dio.post(EndPoints.myOpenJobList,
          options: Options(headers: {
            "Content-Type": 'application/json',
          }),
          data: formData);
      if (response.statusCode == 200) {
        print('getOpenJobList ----- > ${response.data}');
        GetJobListModel responseData = GetJobListModel.fromJson(response.data);
        Loader.hideLoader();
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      print('Dio E  ' + e.toString());
      // throw handleError(e);
    } finally {
      Loader.hideLoader();
    }
  }

  Future<GetJobListModel?> getDraftJobList() async {
    try {
      String? userId1 = await Preferances.getString("userid");
      Loader.showLoader();
      Response response;
      FormData formData = FormData.fromMap({
        "user_id": userId1!.replaceAll('"', '').replaceAll('"', '').toString()
      });
      response = await dio.post(EndPoints.draftJobList,
          options: Options(headers: {
            "Content-Type": 'application/json',
          }),
          data: formData);
      if (response.statusCode == 200) {
        print('getDraftJobList ----- > ${response.data}');
        GetJobListModel responseData = GetJobListModel.fromJson(response.data);
        Loader.hideLoader();
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      print('Dio E  ' + e.toString());
      // throw handleError(e);
    } finally {
      Loader.hideLoader();
    }
  }

  Future<GetJobListModel?> getMyCompletedJobList() async {
    try {
      String? userId1 = await Preferances.getString("userid");
      Loader.showLoader();
      Response response;
      FormData formData = FormData.fromMap({
        "user_id": userId1!.replaceAll('"', '').replaceAll('"', '').toString()
      });
      response = await dio.post(EndPoints.myCompletedJobList,
          options: Options(headers: {
            "Content-Type": 'application/json',
          }),
          data: formData);
      if (response.statusCode == 200) {
        print('myCompletedJobList ----- > ${response.data}');
        GetJobListModel responseData = GetJobListModel.fromJson(response.data);
        Loader.hideLoader();
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      print('Dio E  ' + e.toString());
      // throw handleError(e);
    } finally {
      Loader.hideLoader();
    }
  }

  Future<ResponseModel?> deleteJobApi(String jobId) async {
    try {
      Loader.showLoader();
      Response response;
      FormData formData = FormData.fromMap({"job_id": jobId});
      response = await dio.post(EndPoints.deleteJob,
          options: Options(headers: {
            "Content-Type": 'application/json',
          }),
          data: formData);
      if (response.statusCode == 200) {
        print('deleteJobApi ----- > ${response.data}');
        ResponseModel responseData = ResponseModel.fromJson(response.data);
        CommonFunctions.toast(responseData.message.toString());
        Loader.hideLoader();
        return responseData;
      } else {
        Loader.hideLoader();
        throw Exception(response.data);
      }
    } on DioError catch (e) {
      Loader.hideLoader();
      print('Dio E  ' + e.toString());
      // throw handleError(e);
    } finally {
      Loader.hideLoader();
    }
  }
}
