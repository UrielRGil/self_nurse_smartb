import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_nurse/blocs/ble_bloc/ble_bloc.dart';
import 'package:self_nurse/widgets/widgets.dart';

import '../views/views.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self Nurse'),
        actions: [
          BlocBuilder<BleBloc, BleState>(
            builder: (context, state) {
              if (state.status == BleStatus.connected) {
                return const ConnectionStatus(status: true);
              }
              return const ConnectionStatus(status: false);
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          DeviceDataView(),
          DevicesListView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          )
        ],
        onTap: (index) {
          setState(() {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInCirc);
            currentIndex = index;
          });
        },
      ),
    );
  }
}
