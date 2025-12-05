import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(context) {
    const List<_NavigationDestination> destinations = [
      _NavigationDestination(icon: Icon(Icons.home), label: 'ホーム'),
      _NavigationDestination(icon: Icon(Icons.checklist), label: 'タスク'),
      _NavigationDestination(icon: Icon(Icons.calendar_month), label: 'スケジュール'),
      _NavigationDestination(icon: Icon(Icons.settings), label: '設定'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final BoxConstraints(:maxWidth, :maxHeight) = constraints;

        if (maxHeight > maxWidth) {
          // 縦画面
          return _ScaffoldWithBottomNav(
            navigationShell: navigationShell,
            destinations: destinations,
            onTap: _onTap,
          );
        } else {
          // 横画面
          return _ScaffoldWithNavigationRail(
            navigationShell: navigationShell,
            destinations: destinations,
            onTap: _onTap,
          );
        }
      },
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _ScaffoldWithBottomNav extends StatelessWidget {
  const _ScaffoldWithBottomNav({
    required this.navigationShell,
    required this.destinations,
    required this.onTap,
  });

  final StatefulNavigationShell navigationShell;
  final List<_NavigationDestination> destinations;
  final Function(BuildContext context, int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => onTap(context, index),
        destinations: destinations.map((d) => d.toNav()).toList(),
      ),
    );
  }
}

class _ScaffoldWithNavigationRail extends StatelessWidget {
  const _ScaffoldWithNavigationRail({
    required this.navigationShell,
    required this.destinations,
    required this.onTap,
  });

  final StatefulNavigationShell navigationShell;
  final List<_NavigationDestination> destinations;
  final Function(BuildContext context, int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => onTap(context, index),
            labelType: NavigationRailLabelType.all,
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            destinations: destinations.map((d) => d.toNavRail()).toList(),
          ),
          // 残りのスペースをナビゲーションシェルで埋める
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

class _NavigationDestination {
  const _NavigationDestination({required this.icon, required this.label});

  final Icon icon;
  final String label;

  NavigationDestination toNav() {
    return NavigationDestination(icon: icon, label: label);
  }

  NavigationRailDestination toNavRail() {
    return NavigationRailDestination(icon: icon, label: Text(label));
  }
}
