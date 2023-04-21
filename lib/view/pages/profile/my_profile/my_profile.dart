import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/models/uploadImage.dart';
import 'package:dalog_distribution/provider/user_id_provider.dart';
import 'package:dalog_distribution/services/auth_service.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helper/shared_preferance.dart';
import '../../../../models/verify_otp.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  File? image;
  File? _file;
  String imageUrl = '';
  VerifyOtp? user;

  final TextEditingController _firstName = TextEditingController();

  final TextEditingController _lastName = TextEditingController();

  final TextEditingController _email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userData = preferences.getString("user");
    user = await VerifyOtp.fromJson(jsonDecode(userData!));
    print('user data --> ${user!.toJson()}');
    _firstName.text = user?.firstName ?? "";
    _lastName.text = user?.lastName ?? "";
    _email.text = user?.email ?? "";
    imageUrl = user?.image ?? '';
    setState(() {});
    //print(user.token);
  }

  @override
  Widget build(BuildContext context) {
    // imageUrl = user?.image ?? '';
    // getData();
    return Scaffold(
      appBar: SecondaryAppBar(
        isLeading: false,
        title: "My Profile",
      ),
      body: CustomScroll(
        children: [
          SizedBoxH28(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [profilePhoto(context)],
          ),
          SizedBoxH28(),
          Row(
            children: [
              Flexible(
                  child: PrimaryTextField(
                hintText: "First Name",
                controller: _firstName,
              )),
              SizedBoxW8(),
              Flexible(
                  child: PrimaryTextField(
                hintText: "Last Name",
                controller: _lastName,
              ))
            ],
          ),
          PrimaryTextField(
            hintText: "Email Address",
            readOnly: true,
            controller: _email,
          ),
          PrimaryButton(
              lable: "Save",
              onPressed: () async {
                String? userid = await Preferances.getString("userid");
                print(userid);
                UploadImage uploadImage =UploadImage();
                if(_file != null){
                  FormData formData = FormData.fromMap(
                      {"image": await MultipartFile.fromFile(_file!.path)});
                   uploadImage =
                  await ApiService().uploadImage(context, data: formData);
                }
                await ApiService().updateProfile(context,
                    data: _data(
                        image: uploadImage.filepathUrl.toString(),
                        userid: userid!.replaceAll('"', '').replaceAll('"', '')));

                //
                // print("${_file!.path}hellooooo");
                //
                // await ApiService().uploadImage(context, data: formData);
              })
        ],
      ),
    );
  }

  FormData _data({String? image, String? userid}) {
    return FormData.fromMap({
      "user_id": userid.toString(),
      "first_name": _firstName.text,
      "last_name": _lastName.text,
      "image": image
    });
  }

  Widget getProfileView() {
    return Container(
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 95,
            width: 95,
            margin: const EdgeInsets.only(bottom: 08),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white),
                image: _file != null
                    ? DecorationImage(
                        image: FileImage(_file!), fit: BoxFit.fill)
                    : imageUrl.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(imageUrl.toString()),
                            fit: BoxFit.fill)
                        : const DecorationImage(
                            image: AssetImage(AppAsset.profileImage),
                            fit: BoxFit.fill)),
          ),
          Positioned(
            bottom: 0,
            right: MediaQuery.of(context).size.width / 2.50,
            child: InkWell(
              onTap: () {
                openCameraButton(context);
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                    color: AppColor.red,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: SvgPicture.asset(
                  AppAsset.camera,
                  height: Sizes.s20.h,
                  width: Sizes.s20.w,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget profilePhoto(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      // CachedNetworkImage(
      //     imageUrl: _file ?? "",
      //     errorWidget: (ctx, url, error) => CircleAvatar(
      //           radius: Sizes.s76.r,
      //           backgroundImage: const AssetImage(AppAsset.profileImage),
      //         ),
      //     placeholder: (ctx, url) => CircleAvatar(
      //           radius: Sizes.s76.r,
      //           backgroundImage: const AssetImage(AppAsset.profileImage),
      //         )),

      CircleAvatar(
          radius: Sizes.s76.r,
          backgroundImage: _file != null
              ? FileImage(_file!)
              : imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl.toString())
                  : AssetImage(AppAsset.profileImage) as ImageProvider

          // child: _file != null
          //     ? Image.file(
          //         _file!,
          //       )
          //     : ClipOval(
          //         child: Image.asset(
          //           AppAsset.profileImage,
          //           fit: BoxFit.fill,
          //         ),
          //       )
          ),
      Positioned.fill(
          bottom: -12,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: openCameraButton(context),
          ))
    ]);
  }

  Widget openCameraButton(BuildContext context) {
    return InkWell(
      onTap: () {
        selectImage(context);
      },
      child: CircleAvatar(
        backgroundColor:
            Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
                ? AppColor.black
                : AppColor.white,
        radius: Sizes.s20.r,
        child: CircleAvatar(
            radius: Sizes.s18.r,
            backgroundColor: AppColor.red,
            child: SvgPicture.asset(
              AppAsset.camera,
              height: Sizes.s20.h,
              width: Sizes.s20.w,
            )),
      ),
    );
  }

  Future<void> selectImage(BuildContext context) async {
    File? file = await FileUtils.pickImage(ImageSource.gallery);
    if (file != null) {
      setState(() {
        _file = file;
      });
    }
  }

// FormData formData() {
//   return FormData.fromMap({});
// }
}
