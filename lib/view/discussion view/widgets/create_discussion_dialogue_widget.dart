import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hobby_club_app/utils/app_colors.dart';
import 'package:hobby_club_app/utils/dimensions.dart';


class CreateNewDiscussionWidget extends StatelessWidget {
  const CreateNewDiscussionWidget({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    // required this.discussionsController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  // final DiscussionsController discussionsController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        "Create Discussion",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title';
                  }
                  return null; // valid
                },
                controller: titleController,
                cursorColor: Colors.black,

                decoration: InputDecoration(
                  // labelText: "Title",
                  hint: const Text('Title'),
                  fillColor: AppColors.primary.withValues(alpha: 0.1),
                  filled: true,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null; // valid
                },
                cursorColor: Colors.black,
                controller: descriptionController,
                decoration: InputDecoration(
                  hint: const Text('Description'),
                  fillColor: AppColors.primary.withValues(alpha: 0.1),
                  filled: true,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              //
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    // create discussions
                    if (formKey.currentState!.validate()) {
                      // if (!discussionsController.isLoading.value) {
                      //   bool res = await discussionsController
                      //       .createClubDiscussions(
                      //         clubId: '8',
                      //         title: titleController.text,
                      //         description: descriptionController.text,
                      //       );
                      //   if (res) {
                      //     Get.back();
                      //     Get.showSnackbar(
                      //       const GetSnackBar(
                      //         title: 'Discussion Created Succefully',
                      //       ),
                      //     );
                      //     Get.back();
                      //   } else {
                      //     Get.showSnackbar(
                      //       const GetSnackBar(
                      //         title: 'Failed to create Discussion',
                      //       ),
                      //     );
                      //   }
                      // }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.padding15,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.cardRadius,
                      ),
                      color: AppColors.primary,
                    ),

                    child: Center(
                      // child: discussionsController.isLoading.value
                      //     ? const SizedBox(
                      //         height: 25,
                      //         width: 25,
                      //         child: CircularProgressIndicator(
                      //           color: Colors.white,
                      //         ),
                      //       )
                      //     : Text(
                      //         "Create",
                      //         style: TextStyle(
                      //           fontSize: Dimensions.font16,
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // actions: [
      //   // TextButton(
      //   //   onPressed: () {
      //   //     Navigator.of(context).pop(); // Close dialog
      //   //   },
      //   //   child: const Text("Cancel"),
      //   // ),

      // ],
    );
  }
}
