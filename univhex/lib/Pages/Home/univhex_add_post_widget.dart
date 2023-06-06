// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Widgets/univhex_progress_indicator.dart';

import '../../Constants/current_user.dart';
import '../../Firebase/firestore.dart';
import '../../Objects/univhex_post.dart';

class UnivhexAddPostWidget extends HookWidget {
  UnivhexAddPostWidget({
    Key? key,
    required this.onPressed,
    required this.focusNode,
  }) : super(key: key);

  final VoidCallback onPressed;
  final FocusNode focusNode;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final isAnonymous = useState(false);
    final pickedImage = useState<XFile?>(null);
    final imageUrl = useState<String?>(null);
    final isUploading = useState<bool>(false);

    return Column(
      children: [
        const Divider(
          height: 0,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Expanded(child: _buildTextField(textController, pickedImage)),
              const SizedBox(width: 10),
              _buildSendPost(isAnonymous, textController, pickedImage, imageUrl,
                  isUploading),
            ],
          ),
        ),
        _buildSwitch(isAnonymous),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: pickedImage.value != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(pickedImage.value!.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  /// Picks an image from the gallery.
  Future<XFile?> _pickImage() => _picker.pickImage(source: ImageSource.gallery);

  Future<String?> uploadImgToFire(
    ValueNotifier<XFile?> pickedImage,
  ) async {
    if (pickedImage.value != null) {
      String url = await uploadImageToFirebase(pickedImage.value!);
      return url;
    }
    return null;
  }

  /// Builds a [IconButton] to send the post.
  Widget _buildSendPost(
    ValueNotifier<bool> isAnonymous,
    TextEditingController textController,
    ValueNotifier<XFile?> pickedImage,
    ValueNotifier<String?> imageUrl,
    ValueNotifier<bool> isUploading,
  ) =>
      IconButton(
        onPressed: !isUploading.value
            ? () async {
                String? imgUrl;
                isUploading.value = true;
                await uploadImgToFire(pickedImage)
                    .then((value) => imgUrl = value);

                final newPost = UnivhexPost(
                  id: "",
                  authorId: CurrentUser.user!.id,
                  university: CurrentUser.user!.university!,
                  textContent: textController.text,
                  isAnonymous: isAnonymous.value,
                  dateTime: DateTime.now(),
                  hexedBy: [],
                  hexCount: 0,
                  comments: [],
                  media: imgUrl,
                );

                if (await addNewPostDB(newPost)) {
                  isUploading.value = false;
                }

                isAnonymous.value = false;
                textController.clear();
                pickedImage.value = null;
                imageUrl.value = null;

                onPressed();
              }
            : () {},
        icon: !isUploading.value
            ? Icon(
                Icons.send_outlined,
                color: !isAnonymous.value
                    ? AppColors.myPurple
                    : AppColors.myLightBlue,
              )
            : const SizedBox(
                height: 50,
                width: 50,
                child: UnivhexProgressIndicator(isHorizontal: true),
              ),
      );

  /// Uploads an image to Firebase Storage.
  Future<String> uploadImageToFirebase(XFile imageFile) async {
    File file = File(imageFile.path);
    try {
      String filePath = 'images/${DateTime.now()}.png';
      await FirebaseStorage.instance.ref(filePath).putFile(file);

      String downloadURL =
          await FirebaseStorage.instance.ref(filePath).getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
      return '';
    }
  }

  /// Builds an [IconButton] to pick an image.
  Widget _buildPickImg(ValueNotifier<XFile?> pickedImage) => IconButton(
        onPressed: () async {
          final XFile? image = await _pickImage();
          if (image != null) {
            pickedImage.value = image;
          }
        },
        icon: const Icon(
          Icons.add_a_photo_outlined,
          color: AppColors.myBlue,
        ),
      );

  /// Builds a [TextField] with the given [textController].
  Widget _buildTextField(TextEditingController textController,
          ValueNotifier<XFile?> pickedImage) =>
      Column(
        children: [
          TextField(
            controller: textController,
            focusNode: focusNode,
            keyboardType: TextInputType.name,
            minLines: 1,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: "What's on your mind?",
              border: InputBorder.none,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: _buildPickImg(pickedImage),
          ),
        ],
      );

  /// Builds a [Switch] widget.
  ///
  /// This function builds a [Switch] widget using the given [isAnonymous]
  /// [ValueNotifier] to determine the value of the switch and the given
  /// [onChanged] callback to handle user input.
  Widget _buildSwitch(ValueNotifier<bool> isAnonymous) => Align(
        alignment: Alignment.centerLeft,
        child: SwitchListTile(
          activeColor: AppColors.myLightBlue,
          inactiveThumbColor: AppColors.myPurple,
          dense: true,
          title: const Text("Anonymous"),
          value: isAnonymous.value,
          onChanged: (value) => isAnonymous.value = value,
        ),
      );
}
