import 'package:flutter/material.dart';

import 'package:mobile_football/navigation/app_coordinator.dart';
import 'package:mobile_football/screens/grid_screens/teams_grid_screen.dart';
import 'package:mobile_football/screens/table_screens/standing_table_screen.dart';
import 'package:mobile_football/screens/table_screens/match_table_screen.dart';

class MainSeasonTabScreen extends StatefulWidget {
  const MainSeasonTabScreen({
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

  final AppCoordinator? _coordinator;

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
        title: Text(widget.title),
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
            title: widget.title,
            leagueId: widget.leagueId,
            season: widget.season.toString(),
            hasSearchBar: false,
            coordinator: widget._coordinator,
          ),
          MatchTableScreen(
            title: widget.title,
            leagueId: widget.leagueId,
            season: widget.season,
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