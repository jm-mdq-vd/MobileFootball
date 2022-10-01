import 'package:flutter/material.dart';

import 'package:mobile_football/screens/grid_screens/teams_grid_screen.dart';
import 'package:mobile_football/screens/table_screens/standing_table_screen.dart';
import 'package:mobile_football/screens/table_screens/fixture_table_screen.dart';
import 'package:mobile_football/screens/screen_requirements.dart';

class MainSeasonTabScreen extends StatefulWidget {
  const MainSeasonTabScreen({
    super.key,
    required LeagueSeasonRequirements requirements,
    required this.isCup,
  }) : _requirements = requirements;

  final LeagueSeasonRequirements _requirements;
  final bool isCup;

  @override
  State<MainSeasonTabScreen> createState() => _MainSeasonTabScreenState();
}

class _MainSeasonTabScreenState extends State<MainSeasonTabScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    final length = !widget.isCup ? 3 : 2;
    _controller = TabController(length: length, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._requirements.title),
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'EQUIPOS',),
            Tab(text: 'PARTIDOS',),
            if (!widget.isCup) Tab(text: 'POSICIONES',),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          TeamsGridScreen(
            requirements: widget._requirements,
            hasSearchBar: false,
          ),
          FixtureTableScreen(requirements: widget._requirements,),
          if (!widget.isCup)
            StandingTableScreen(requirements: widget._requirements,),
        ],
      ),
    );
  }
}