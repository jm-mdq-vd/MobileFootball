import 'package:flutter/material.dart';

import 'package:mobile_football/navigation/app_coordinator.dart';
import 'package:mobile_football/screens/grid_screens/teams_grid_screen.dart';
import 'package:mobile_football/screens/table_screens/standing_table_screen.dart';

class MainSeasonTabScreen extends StatefulWidget {
  MainSeasonTabScreen({
    super.key,
    required this.isCup,
    required this.title,
    required this.leagueId,
    required this.season,
    AppCoordinator? coordinator,
  }) : _coordinator = coordinator;

  final String title;
  final String leagueId;
  final String season;
  final bool isCup;

  AppCoordinator? _coordinator;

  @override
  State<MainSeasonTabScreen> createState() => _MainSeasonTabScreenState();
}

class _MainSeasonTabScreenState extends State<MainSeasonTabScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    print(widget._coordinator);

    final length = !widget.isCup ? 2 : 1;
    _controller = TabController(length: length, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'EQUIPOS',),
            if (!widget.isCup) Tab(text: 'POSICIONES',),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          TeamsGridScreen(
            title: widget.title,
            leagueId: widget.leagueId,
            season: widget.season.toString(),
            hasSearchBar: false,
            coordinator: widget._coordinator,
          ),
          if (!widget.isCup)
            StandingTableScreen(
              title: widget.title,
              leagueId: widget.leagueId,
              season: widget.season,
              coordinator: widget._coordinator,
            ),
        ],
      ),
    );
  }
}