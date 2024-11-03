import 'dart:io';
import 'package:flutter/material.dart';

class UpPostScreens extends StatelessWidget {
  final List<File>? imagesList;

  const UpPostScreens({super.key, this.imagesList});

  @override
  Widget build(BuildContext context) {
    return UpPostPage(imagesList: imagesList);
  }
}

class UpPostPage extends StatefulWidget {
  final List<File>? imagesList;

  const UpPostPage({super.key, this.imagesList});

  @override
  State<UpPostPage> createState() => _UpPostPageState();
}

class _UpPostPageState extends State<UpPostPage> {
  final TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("New Post"),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Thực hiện logic upload bài viết
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: captionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Write a caption...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: widget.imagesList != null && widget.imagesList!.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: widget.imagesList!.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              // Đặt bán kính bo tròn
                              child: Image.file(
                                widget.imagesList![index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.imagesList!.removeAt(index);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : const Center(
                      child: Text("No images selected"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
