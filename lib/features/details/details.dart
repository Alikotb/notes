import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}


class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final fabSpacing = screenHeight * 0.08;
    final fabPadding = screenHeight * 0.025;

    return Scaffold(
      backgroundColor: const Color(0xFF252525),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF3B3B3B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Gap(12),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white60, fontSize: 48, fontWeight: FontWeight.normal),
                    hintText: "Title",
                  ),
                  onChanged: (value) {},
                  obscureText: false,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              Container(
                width: screenWidth,
                height: screenHeight * 0.7,
                padding: EdgeInsets.only(left: 8),
                child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white60, fontSize: 24),
                    hintText: "Type your note here...",
                  ),
                  onChanged: (value) {},
                  obscureText: false,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  maxLines: null,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: fabSpacing + fabPadding, right: 16),
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.black,
                foregroundColor: Colors.white70,
                elevation: 10,
                shape: const CircleBorder(),
                splashColor: Colors.grey,
                highlightElevation: 10,
                focusElevation: 10,
                focusColor: Colors.grey,
                child: const Icon(
                  Icons.clear,
                  size: 35,
                  weight: 900,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: fabPadding, right: 16),
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.black,
                foregroundColor: Colors.white70,
                elevation: 10,
                shape: const CircleBorder(),
                splashColor: Colors.grey,
                highlightElevation: 10,
                focusElevation: 10,
                focusColor: Colors.grey,
                child: const Icon(
                  Icons.add,
                  size: 35,
                  weight: 900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


