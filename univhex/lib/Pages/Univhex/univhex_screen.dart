import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/Constants.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/firestore.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';
import 'package:univhex/Pages/Univhex/univhex.dart';
import 'package:univhex/Widgets/univhex_progress_indicator.dart';

import 'univhex_widget.dart';

@RoutePage(name: 'UnivhexPageRoute')
class UnivhexPage extends StatefulWidget {
  const UnivhexPage({super.key});

  @override
  State<UnivhexPage> createState() => _UnivhexPageState();
}

class _UnivhexPageState extends State<UnivhexPage> {
  _createUnivhexListData() async {
    List<Univhex> univhexMap = [];
    for (var university in Constants.schools) {
      List<UnivhexPost> univhexlist = await fetchUnivhexes(university);
      Univhex newUnivhex = Univhex(uniName: university, univhexes: univhexlist);
      univhexMap.add(newUnivhex);
    }

    return univhexMap;
  }

  Future<void> _onRefresh() {
    setState(() {});
    return Future.delayed(Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 13),
          child: Image.asset("assets/images/icon.png"),
        ),
        title: const Text("UNIVHEX"),
      ),
      body: RefreshIndicator(
        color: AppColors.myLightBlue,
        backgroundColor: AppColors.bgColor,
        onRefresh: _onRefresh,
        child: FutureBuilder(
          future: _createUnivhexListData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: UnivhexProgressIndicator(isHorizontal: false),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No data available'),
              );
            }
            List<Univhex> univhexList = snapshot.data as List<Univhex>;
            return ListView.builder(
              itemCount: univhexList.length,
              itemBuilder: (context, index) {
                Univhex univhex = univhexList[index];
                int i = -1;
                return univhex.univhexes.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            univhex.uniName,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: AppColors.obsidianInvert),
                          ),
                          for (var univhexPost in univhex.univhexes)
                            Column(
                              children: [
                                UnivhexWidget(
                                  post: univhexPost,
                                  order: i,
                                ),
                                if (++i <= univhex.univhexes.length)
                                  const Divider(
                                    thickness: 1.5,
                                  ),
                              ],
                            ),
                        ],
                      )
                    : const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
