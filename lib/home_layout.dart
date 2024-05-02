import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post_planning_app/view/account_screen.dart';
import 'package:post_planning_app/view/create_shudle_screen.dart';
import 'package:post_planning_app/view/history_screen.dart';
import 'package:post_planning_app/view/home_screen.dart';
import 'package:post_planning_app/view/pending_screen.dart';
import 'package:post_planning_app/shared/colors.dart';
import 'package:post_planning_app/view/profile_screen.dart';




class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0 ;

  final _pageController = PageController(initialPage:0);

  /// widget list
  final List<Widget> bottomBarPages = [
    HomeScreen(),
    PendingScreen(),
    HistoryScreen(),
    ProfilScreen(),
  ];
  final List<String> barLabels = [
    'Latest Post',
    'Pending Posts',
    'History',
    'Profile ',


  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show a dialog to confirm app exit
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm exit'),
            content: Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ).then((value) {
          // If the user confirmed, close the app
          if (value == true) {
            SystemNavigator.pop();
          }
        });

        // Always return false to prevent the user from leaving the screen
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(barLabels[currentIndex]),
          centerTitle: true,
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white)
            ),
            backgroundColor: mainColor,

            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => const CreateShudleScreen()));
            },
            child: Icon(Icons.add,
              color: Colors.white,
            size: 25,)
        ),
        bottomNavigationBar: BottomAppBar(
          height: 65,
          color: Colors.white,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon:  Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: currentIndex == 0 ? mainColor : Colors.grey,
                  size: 30,
                ),
                onPressed: () {

                  setState(() {
                    currentIndex = 0;
                    _pageController.jumpToPage(0);
                  });

                },
              ),
              Spacer(flex: 1,),
              IconButton(

                icon:  Icon( Icons.history ,
                  color: currentIndex == 1 ? mainColor : Colors.grey,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                    _pageController.jumpToPage(1);
                  });
                },
              ),
              Spacer(flex: 2,),
              IconButton(
                icon:  Icon(currentIndex == 2 ? Icons.save :Icons.save_outlined,
                  color: currentIndex == 2 ? mainColor : Colors.grey,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                    _pageController.jumpToPage(2);
                  });
                },
              ),
              Spacer(flex: 1,),
              IconButton(

                icon:  Icon(Icons.person,
                    color: currentIndex == 3 ? mainColor : Colors.grey,
                    size: 30),
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                    _pageController.jumpToPage(3);
                  });

                },
              ),
            ],
          ),
        ),


      ),
    );
  }
}
