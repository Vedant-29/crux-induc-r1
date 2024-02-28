import 'package:crux_induc/Screens/Main_screens/bottom_sheet/add_expense_bottom_sheet.dart';
import 'package:crux_induc/Screens/Main_screens/recents_page.dart';
import 'package:crux_induc/Screens/Main_screens/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:crux_induc/Screens/Main_screens/widgets/custom_notched_shaped_widget.dart';
import 'package:crux_induc/main.dart';
import 'package:provider/provider.dart';
import 'package:crux_induc/providers/piecolorsProvider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final List<Widget> _screen = <Widget>[
    ChangeNotifierProvider(
    create: (context) => PieChartColors(),
    child: StatsPage(),
  ),
    // Container(),
    RecentsPage(),
  ];

  int selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  } 

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        allowImplicitScrolling: true,
        controller: _pageController,
        onPageChanged: _onPageChanged, 
        physics: NeverScrollableScrollPhysics(),
        children: _screen,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        shape: CustomNotchedShape(),
        notchMargin: 0,
        color: Colors.white,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          // currentIndex:   ,
          onTap: _onItemTapped,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.colorScheme.secondary,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 25,
                color: selectedIndex == 0 ? theme.colorScheme.primary : theme.colorScheme.secondary,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_rounded,
                size: 25,
                color: selectedIndex == 1 ? theme.colorScheme.primary : theme.colorScheme.secondary,
              ),
              label: ''
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(16.0),
        height: 100,
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => AddExspenseBtn(),
            );
          },
          backgroundColor: theme.colorScheme.primary,
          shape: CircleBorder(),
          heroTag: null,
          mini: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(0),
            child: Icon(
              Icons.add, 
              size: 40,
              color: theme.colorScheme.onTertiary,
            ),
          ),
        ),
      ),
    );
  }
}