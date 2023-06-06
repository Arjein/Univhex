import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/Constants.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/firestore.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';
import 'package:univhex/Pages/Univhex/univhex.dart';

import 'univhex_widget.dart';

@RoutePage(name: 'UnivhexPageRoute')
class UnivhexPage extends StatelessWidget {
  const UnivhexPage({super.key});

  _createUnivhexListData() async {
    List<Univhex> univhexMap = [];
    for (var university in Constants.schools) {
      List<UnivhexPost> univhexlist = await fetchUnivhexes(university);
      Univhex newUnivhex = Univhex(uniName: university, univhexes: univhexlist);
      univhexMap.add(newUnivhex);
    }

    return univhexMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: CurrentUser.deviceWidth! * 0.1,
                child: Image.asset("assets/images/icon.png")),
            const Text("UNIVHEX"),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _createUnivhexListData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
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
                  ? Container(
                      height: 0,
                      width: 0,
                      child: Text(
                        "sdaasdasdds",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: AppColors.obsidianInvert),
                      ),
                    )
                  : Container(
                      height: 0,
                      width: 0,
                      child: Text(
                        "sdaasdasdds",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: AppColors.obsidianInvert),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
