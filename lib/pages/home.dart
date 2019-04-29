import 'package:cup_and_soup/pages/home/insider.dart';
import 'package:flutter/material.dart';

import 'package:cup_and_soup/pages/home/store.dart';
import 'package:cup_and_soup/pages/home/account.dart';
import 'package:cup_and_soup/pages/home/scanner.dart';
import 'package:cup_and_soup/pages/home/admin.dart';
import 'package:cup_and_soup/widgets/home/navigationBar.dart';
import 'package:cup_and_soup/services/auth.dart';
import 'package:cup_and_soup/services/cloudFirestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _roles = [];

  Map<String, Map<String, dynamic>> _allPages = {
    'account': {
      'icon': Icons.account_circle,
      'page': AccountPage(),
    },
    'store': {
      'icon': Icons.shopping_cart,
      'page': StorePage(),
    },
    'admin': {
      'icon': Icons.work,
      'page': AdminPage(),
    },
    'adminStore': {
      'icon': Icons.shopping_cart,
      'page': StorePage(
        isAdmin: true,
      )
    },
    'scanner': {
      'icon': Icons.center_focus_strong,
      'page': ScannerPage(goToStore: () => null)
    },
    'insider': {
      'icon': Icons.star,
      'page': InsiderPage(),
    },
  };

  Map<String, Map<String, dynamic>> _pages = {};
  String _currentPage = 'store';

  void getRoles() async {
    List<String> roles = await authService.getRoles();
    setState(() {
      _roles = roles;
    });
    _updatePages();
    if (_roles.contains("admin")) cloudFirestoreService.clearSupriseBox();
  }

  void _updatePages() {
    Map<String, Map<String, dynamic>> pages = {};
    if (_roles.contains('customer')) {
      pages.putIfAbsent('account', () => _allPages['account']);
      pages.putIfAbsent('store', () => _allPages['store']);
      pages.putIfAbsent('scanner', () => _allPages['scanner']);
    }
    if (_roles.contains('admin')) {
      pages.putIfAbsent('admin', () => _allPages['admin']);
      pages.remove('store');
      pages.putIfAbsent('adminStore', () => _allPages['adminStore']);
    }
    if (_roles.contains('insider')) {
      pages.putIfAbsent('insider', () => _allPages['insider']);
    }
    setState(() {
      _pages = pages;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _allPages['scanner']['page'] =
          ScannerPage(goToStore: () => _onTabTaped('store'));
    });
    getRoles();
    cloudFirestoreService.getRequests();
  }

  void _onTabTaped(String page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_roles.contains("cashRegister")
        ? Scaffold(
            body: _pages[_currentPage] != null ?  _pages[_currentPage]['page'] : StorePage(),
            bottomNavigationBar: NavigationBarWidget(
              currentPage: _currentPage,
              tabTapped: _onTabTaped,
              pages: _pages,
            ),
          )
        : Scaffold(
            body: StorePage(),
          );
  }
}
