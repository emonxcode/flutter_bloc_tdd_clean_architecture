import 'dart:io';

import 'package:bloc_clean_architecture_tdd_solid/core/utils/pick.image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/blod.field.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => CupertinoPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  List<String> selectedTopics = [];
  File? selectedImage;
  void selectImage() async {
    var pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Blog"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  selectImage();
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(15),
                  color: Colors.grey,
                  strokeCap: StrokeCap.round,
                  dashPattern: const [20, 5],
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open),
                              Text("Select an image")
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  'Technology',
                  'Business',
                  'Programmning',
                  'Entertainment'
                ].map(
                  (e) {
                    bool isSelected = selectedTopics.contains(e);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTopics.contains(e)
                              ? selectedTopics.remove(e)
                              : selectedTopics.add(e);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Chip(
                          label: Text(e),
                          backgroundColor: isSelected ? Colors.blue : null,
                          side: isSelected
                              ? const BorderSide(
                                  width: 2,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: 10),
              BlogField(
                controller: TextEditingController(),
                hint: "Enter title",
                label: "Blog Title",
                maxLines: 1,
              ),
              const SizedBox(height: 10),
              BlogField(
                controller: TextEditingController(),
                hint: "Enter description",
                label: "Blog description",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
