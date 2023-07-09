// ignore_for_file: must_be_immutable
import 'dart:io';
import 'package:buy_buddy/utils/app_colors.dart';
import 'package:buy_buddy/models/user_model/user_model.dart';
import 'package:buy_buddy/provider/app_provider.dart';
import 'package:buy_buddy/widgets/textfields/custom_textfield.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class EditProfile extends StatefulWidget {
  String name;
  EditProfile({super.key, required this.name});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  ///variable & controller
  File? image;
  TextEditingController nameController = TextEditingController();

  
  ///function to pick image from gallery
  void imgPicker() async {
    XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(

      ///appbar here
      appBar: AppBar(
        title: Text("Edit Profile",style: TextStyle(color: AppColor.primaryColor)),
        centerTitle: true,
      ),

      ///body here
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [

                ///profile pic
                CircleAvatar(
                  radius: 70,
                  backgroundImage: image == null? NetworkImage(appProvider.getUserInfo.image!): FileImage(image!) as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 100,
                  child: CircleAvatar(
                    backgroundColor: AppColor.secondaryLightColor,
                    child: IconButton(
                      onPressed: () {
                        imgPicker();
                      },
                      icon: Icon(
                        EneftyIcons.camera_outline,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),


            ///update name textfield
            CustomTextField(
              prefixIcon: EneftyIcons.user_edit_outline,
              controller: nameController,
              hintText: widget.name,
              keyboadType: TextInputType.text,
            ),

            ///update profile buttons
            Consumer<AppProvider>(
              builder: (context, value, child) => ElevatedButton(
                onPressed: () {
                  UserModel userModel = value.getUserInfo.copyWith(name: nameController.text);
                  value.updateUserInfoFirebase(userModel, image, context);
                },
                child: const Text("Update Profile",style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
