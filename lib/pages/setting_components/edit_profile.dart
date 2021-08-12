import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_States.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_bloc.dart';
import 'package:daily_planner/bloc_services/user_bloc/user_events.dart';
import 'package:daily_planner/components/appbar_widget.dart';
import 'package:daily_planner/components/button_action.dart';
import 'package:daily_planner/components/switch_pages.dart';
import 'package:daily_planner/components/text_input_controller.dart';
import 'package:daily_planner/models/user_model.dart';
import 'package:daily_planner/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  var name, email, id, image;
  EditProfile({
    required this.name,
    required this.email,
    required this.image,
    required this.id,
  });
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isProgress = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late File imageFile;
  late String imageUrl;
  late String name, email;
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = widget.name;
    emailController.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var userProvider = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget.getAppBar("Edit Profile", context),
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 65.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 20.0,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.image,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Image(
                                  image: AssetImage(userImage),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          chooseImageFile();
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22.0,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextInputController(
                          message: "name",
                          icon: Icons.person,
                          onClick: (newValue) {
                            name = newValue;
                          },
                          onValidate: (value) {
                            if (value.isEmpty) {
                              return "this field is required";
                            }
                            return null;
                          },
                          textController: nameController,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextInputController(
                          message: "email",
                          icon: Icons.person,
                          onClick: (newValue) {
                            email = newValue;
                          },
                          onValidate: (value) {
                            if (value.isEmpty) {
                              return "this field is required";
                            }
                            return null;
                          },
                          textController: emailController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                      child: BlocListener<UserBloc, UserStates>(
                    listener: (context, state) {
                      if (state is UserUpdateSucessState) {
                        setState(() {
                          snackbarValidate(state.message, context);
                        });
                      } else if (state is UserUpdateFailedState) {
                        setState(() {
                          isProgress = false;
                        });
                        snackbarValidate(state.error, context);
                      }
                    },
                    child: BlocBuilder<UserBloc, UserStates>(
                      builder: (context, state) {
                        return ButtonAction(
                          title: "Update",
                          onClick: () {
                            setState(
                              () {
                                if (formKey.currentState!.validate()) {
                                  isProgress = true;
                                  userProvider.model1 = UserModel.anotherObj(
                                    id: widget.id,
                                    name: name,
                                    email: email,
                                    image: imageUrl,
                                  );
                                  userProvider.add(UserUpdateEvent());
                                }
                              },
                            );
                          },
                          color: homeColor,
                        );
                      },
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// fetch photo from gallary
  Future chooseImageFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(pickedFile!.path);
    uploadImage();
  }

  // upload the image to firebase storage
  uploadImage() async {
    String fileName = basename(imageFile.path);
    Reference storageReference =
        FirebaseStorage.instance.ref().child('usersImages/$fileName');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.whenComplete(
      () {
        storageReference.getDownloadURL().then(
          (value) {
            print(value);
            imageUrl = value;
          },
        );
      },
    );
  }
}
