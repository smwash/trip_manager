import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trip_manager/helpers/loading.dart';
import 'package:trip_manager/helpers/validators.dart';
import 'package:trip_manager/models/user.dart';
import 'package:trip_manager/services/database.dart';

import '../constants.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  String _newUsername;
  String _userEmail;
  String _prevUserpic;
  String _prevUsername;
  File _fileImage;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.save),
            label: Text(
              'Save',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: _handleUpdateData,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: StreamBuilder<User>(
              stream: Database().getUserData(user.userId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Loader();
                }
                User userData = snapshot.data;
                _userEmail = userData.userEmail;
                _prevUserpic = userData.profilePic;
                _prevUsername = userData.userName;
                return Column(
                  children: [
                    _isLoading ? linearProgress() : Text(''),
                    CircleAvatar(
                      radius: size.height * 0.045,
                      backgroundImage: userData.profilePic != null
                          ? CachedNetworkImageProvider(userData.profilePic)
                          : AssetImage(
                                'assets/images/undraw_profile_pic_ic5t.png',
                              ) ??
                              FileImage(_fileImage),
                    ),
                    FlatButton.icon(
                      icon: Icon(Icons.image),
                      label: Text(
                        'Change Image',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _handleImageChoser,
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      initialValue: userData.userName,
                      decoration: kTripDetailField,
                      validator: (value) =>
                          Validator().profileNameValidator(value),
                      onSaved: (value) => _newUsername = value,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  _handleCameraImagePicker() async {
    try {
      Navigator.pop(context);
      ImagePicker picker = ImagePicker();
      final pickedImage = await picker.getImage(source: ImageSource.camera);
      setState(() => _fileImage = File(pickedImage.path));
    } catch (error) {
      print(error);
    }
  }

  _handleGalleryImagePicker() async {
    try {
      Navigator.pop(context);
      ImagePicker picker = ImagePicker();
      final pickedImage = await picker.getImage(source: ImageSource.gallery);
      setState(() => _fileImage = File(pickedImage.path));
    } catch (error) {
      print(error);
    }
  }

  _handleImageChoser() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text('Choose Imge from'),
          children: [
            SimpleDialogOption(
              child: Text('Take from camera'),
              onPressed: _handleCameraImagePicker,
            ),
            SimpleDialogOption(
              child: Text('Choose from gallery'),
              onPressed: _handleGalleryImagePicker,
            ),
            SimpleDialogOption(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  _handleUpdateData() async {
    FocusScope.of(context).unfocus();
    final user = Provider.of<User>(context, listen: false);
    final _db = Database();

    final isValid = _formKey.currentState.validate();
    try {
      setState(() => _isLoading = true);
      if (isValid && _fileImage != null) {
        _formKey.currentState.save();
        var newUser = User(
          userId: user.userId,
          userEmail: _userEmail,
          userName: _newUsername ?? _prevUsername,
          profilePic: File(_fileImage.path).toString() ?? _prevUserpic,
        );
        _db.updateUserData(newUser);
        //setState(() => _isLoading = false);
        Navigator.pop(context);
      } else if (!isValid) {
        setState(() => _isLoading = false);
        return null;
      }
    } catch (error) {
      setState(() => _isLoading = false);
      print(error);
    }
  }
}
