import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/presentation/utils/constant/constant.dart';

class BotNavBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const BotNavBar({required this.navigationShell, super.key});

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _currentIndex = 0;

  ///Pop Scope Function

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  final List<BottomNavigationBarItem> _bottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: IconNavBar(
        iconPath: homeIcon,
        color: Colors.transparent,
      ),
      activeIcon: IconNavBar(
        iconPath: homeActiveIcon,
        color: Colors.blueAccent,
      ),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: IconNavBar(
        iconPath: buildingIcon,
        color: Colors.transparent,
      ),
      activeIcon: IconNavBar(
        iconPath: buildingActiveIcon,
        color: Colors.blueAccent,
      ),
      label: "Gedung",
    ),
    const BottomNavigationBarItem(
      icon: IconNavBar(
        iconPath: reservationIcon,
        color: Colors.transparent,
      ),
      activeIcon: IconNavBar(
        iconPath: reservationActiveIcon,
        color: Colors.blueAccent,
      ),
      label: "Reservasi",
    ),
    const BottomNavigationBarItem(
      icon: IconNavBar(
        iconPath: historyIcon,
        color: Colors.transparent,
      ),
      activeIcon: IconNavBar(
        iconPath: historyActiveIcon,
        color: Colors.blueAccent,
      ),
      label: "Riwayat",
    ),
    const BottomNavigationBarItem(
      icon: IconNavBar(
        iconPath: profileIcon,
        color: Colors.transparent,
      ),
      activeIcon: IconNavBar(
        iconPath: profileActiveIcon,
        color: Colors.blueAccent,
      ),
      label: "Saya",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: widget.navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _goToBranch(_currentIndex);
        },
        items: _bottomNavigationBarItem,
      ),
    );
  }
}

class IconNavBar extends StatelessWidget {
  const IconNavBar({
    super.key,
    required this.iconPath,
    required this.color,
  });

  final String iconPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
          child: Image.asset(
            iconPath,
            scale: 1,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
