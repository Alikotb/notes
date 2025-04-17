import 'package:flutter/material.dart';
import 'package:notes/route/app_route.dart';

import 'component/more_options_menu.dart';
import 'component/note_item.dart';
import 'component/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color(0xFF252525),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF252525),
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Notes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          MoreOptionsMenu(
            isDarkMode: isDarkMode,
            onThemeToggle: (bool newValue) {

            },
          ),
        ],
      ),

      body: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.details);
                  },
                  child: NoteItem(),
                );
              },
              childCount: 20,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
            ),
          ),

        ],
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/details');
          },
          backgroundColor: Colors.black,
          foregroundColor: Colors.white70,
          elevation: 10,
          shape: const CircleBorder(),
          splashColor: Colors.grey,
          child: const Icon(Icons.add, size: 35, weight: 900),
        ),
      ),
    );
  }
}
