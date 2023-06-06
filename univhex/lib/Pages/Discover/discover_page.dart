import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Pages/Discover/discover_tile.dart';

@RoutePage(name: 'DiscoverPageRoute')
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<AppUser> _currentList = [];

  Future<void> searchUsers(String searchTerm) async {
    if (searchTerm == null || searchTerm.trim() == '') {
      _currentList = [];
      return;
    }
    final query = await FirebaseFirestore.instance
        .collection('Users')
        .orderBy('Name')
        .where('University',
            isEqualTo: CurrentUser.user!.university!.toLowerCase())
        .startAt([searchTerm])
        .endAt(['$searchTerm\uf8ff'])
        .limit(10)
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (AppUser user, options) => user.toFirestore(),
        )
        .get();
    _currentList = query.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(24, 2, 24, 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.myLightBlue,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: AppColors.obsidianInvert),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.name,
                  autocorrect: false,
                  onChanged: (value) async {
                    await searchUsers(value);
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
        body: DiscoverList(searchResults: _currentList),
      );
}

class DiscoverList extends StatefulWidget {
  const DiscoverList({
    super.key,
    required this.searchResults,
  });
  final List<AppUser> searchResults;
  @override
  State<DiscoverList> createState() => _DiscoverListState();
}

class _DiscoverListState extends State<DiscoverList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.searchResults.length,
      itemBuilder: (context, index) {
        final user = widget.searchResults[index];
        // Customize how you want to display each user in the list
        return DiscoverTile(
          user: user,
          image: user.getImageProvider(),
        );
      },
    );
  }
}
