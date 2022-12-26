import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/app_user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.currentUser});
  final AppUser currentUser; // Current user is required.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          currentUser.email!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              /* TODO 
          Navigate to settings page, where user can change some required settings.
          */
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        children: [
          CurrentUser.addVerticalSpace(3),
          SizedBox(
            height: CurrentUser.deviceHeight! * 0.22,
            width: CurrentUser.deviceWidth,
            child: Column(
              children: [
                HexagonWidget.flat(
                  width: CurrentUser.deviceWidth! * 0.4,
                  color: AppColors.myPurple,
                  child: AspectRatio(
                    aspectRatio: HexagonType.FLAT.ratio,
                    child: HexagonWidget.flat(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: AspectRatio(
                        aspectRatio: HexagonType.FLAT.ratio,
                        child: Center(
                          child: Image.asset(
                            'assets/images/icon.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        /* Image is uploaded via: 
                        Image.asset(
                          'assets/images/icon.png',
                          fit: BoxFit.fitWidth,
                        ),
                        */
                      ),
                    ),
                  ),
                ),
                CurrentUser.addVerticalSpace(1.3),
                Text(
                  "${currentUser.name} ${currentUser.surname}",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                currentUser.hexPoints.toString(),
                style: Theme.of(context).textTheme.headline3,
              ),
              CurrentUser.addHorizontalSpace(2),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.13,
                child: Image.asset("assets/images/icon.png"),
              ),
            ],
          ),
          CurrentUser.addVerticalSpace(1.2),
          const ProfileTabBar()
        ],
      ),
    );
  }
}

class ProfileTabBar extends StatefulWidget {
  const ProfileTabBar({super.key});

  @override
  State<ProfileTabBar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<ProfileTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        color: AppColors.myBlack,
        height: CurrentUser.deviceHeight! * 0.46,
        child: Column(
          children: const [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.post_add_outlined)),
                Tab(icon: Icon(Icons.question_mark)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UserPostList(),
                  UserInformation(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInformation extends StatelessWidget {
  // This is the personal information view which is found in profile's '?'. Edit as you like --> (Cagla Köse)
  const UserInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, String> _gradeMap = {1: 'st', 2: 'nd', 3: 'rd', 4: "th"};
    int grade = int.parse(CurrentUser.user!.yearOfStudy!);
    String year = _gradeMap[grade]!;
//
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(CurrentUser.user!.university!),
          CurrentUser.addVerticalSpace(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(CurrentUser.user!.fieldOfStudy!),
              Text("${CurrentUser.user!.yearOfStudy!}$year Grade"),
            ],
          ),
        ],
      ),
    );
  }
}

class UserPostList extends StatelessWidget {
  const UserPostList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 3 columns. If you change the scrollDirection to
      // horizontal, this produces 3 rows.
      crossAxisCount: 3,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(10, (index) {
        return Center(
          child: Text(
            // This should be a minimal postview.
            'POST $index',
            style: Theme.of(context).textTheme.headline5,
          ),
        );
      }),
    );
  }
}
