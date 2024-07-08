import 'package:flutter/material.dart';
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
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: Image.asset(
                        'assets/images/exit.png',
                      ),
                    ),
                  ),
                  const Text(
                    'Apakah kamu yakin ingin keluar?',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Tidak',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Keluar',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        )) ??
        false;
  }

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
