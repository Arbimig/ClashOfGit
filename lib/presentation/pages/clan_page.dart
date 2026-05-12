import 'package:cached_network_image/cached_network_image.dart';
import 'package:clashofclans/data/api/service/clan_api.dart';
import 'package:clashofclans/data/bloc/player_cubit.dart';
import 'package:clashofclans/data/bloc/switch_player_cubit.dart';
import 'package:clashofclans/domain/models/clan_model.dart';
import 'package:clashofclans/internal/app_strings.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../internal/apps_page.dart';

class ClanPage extends StatefulWidget {
  @override
  _ClanPageState createState() => _ClanPageState();
}

class _ClanPageState extends State<ClanPage> {
  final TextEditingController _searchController = TextEditingController();
  ClanModel? _searchedClan;
  bool _isSearching = false;
  String? _searchError;

  Future<void> _searchClan(String tag) async {
    if (tag.isEmpty) return;
    setState(() {
      _isSearching = true;
      _searchError = null;
    });
    try {
      final clan = await GetClanInfo().getData(tag);
      setState(() {
        _searchedClan = clan;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _searchError = 'Clan not found';
        _searchedClan = null;
        _isSearching = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    playerCubitFunc = context.read<PlayerCubit>();
    return BlocBuilder<SwitchPlayerCubit, PlayerIndex>(
      builder: (context, profIndex) {
        if (profIndex is PlayerIndexState) {
          return BlocBuilder<PlayerCubit, PlayerState>(
            builder: (context, state) {
              if (state is PlayerLoadingState) {
                return FutureBuilder(
                  future: playerCubitFunc.fplayerInfo(profIndex.index),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final player = snapshot.data;
                      if (player?.clan != null) {
                        return _buildClanFromPlayer(player!);
                      } else {
                        return _buildNoClan();
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                );
              }
              return Container();
            },
          );
        }
        if (profIndex is NoPlayerIndexState) {
          return Center(child: Text('Add a player first'));
        }
        return Container();
      },
    );
  }

  Widget _buildClanFromPlayer(player) {
    final clanTag = player.clan!.tag;
    return FutureBuilder<ClanModel>(
      future: GetClanInfo().getData(clanTag.replaceFirst('#', '')),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading clan info'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
          );
        }
        if (snapshot.hasData) {
          return _buildClanContent(snapshot.data!);
        }
        return Center(child: Text('No clan data'));
      },
    );
  }

  Widget _buildNoClan() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 32),
          Icon(Icons.group_off, size: 64, color: themeData.primaryColor.withOpacity(0.5)),
          SizedBox(height: 16),
          Text(
            'You are not in a clan',
            style: themeData.textTheme.titleLarge,
          ),
          SizedBox(height: 24),
          Text(
            'Search for a clan by tag:',
            style: themeData.textTheme.titleMedium,
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: '#ClanTag',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: (value) => _searchClan(value.replaceFirst('#', '')),
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _searchClan(_searchController.text.replaceFirst('#', '')),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (_isSearching)
            CircularProgressIndicator()
          else if (_searchError != null)
            Text(_searchError!, style: TextStyle(color: Colors.red))
          else if (_searchedClan != null)
            _buildClanContent(_searchedClan!),
        ],
      ),
    );
  }

  Widget _buildClanContent(ClanModel clan) {
    return RefreshIndicator(
      onRefresh: () async => setState(() {}),
      child: ListView(
        padding: EdgeInsets.all(12),
        children: [
          _buildClanHeaderCard(clan),
          SizedBox(height: 12),
          _buildClanInfoCard(clan),
          SizedBox(height: 12),
          _buildWarInfoCard(clan),
          SizedBox(height: 12),
          _buildLabelsCard(clan),
          SizedBox(height: 12),
          _buildMembersCard(clan),
        ],
      ),
    );
  }

  Widget _buildClanHeaderCard(ClanModel clan) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            if (clan.badgeUrls.medium.isNotEmpty)
              CachedNetworkImage(
                imageUrl: clan.badgeUrls.medium,
                height: 60,
                width: 60,
                placeholder: (context, url) => SizedBox(
                  height: 60,
                  width: 60,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.shield, size: 60),
              )
            else
              Icon(Icons.shield, size: 60),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clan.name,
                    style: themeData.textTheme.headlineSmall,
                  ),
                  Text(
                    clan.tag,
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      color: themeData.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Chip(
                        label: Text('Level ${clan.clanLevel}'),
                        backgroundColor: themeData.colorScheme.secondary.withOpacity(0.2),
                      ),
                      SizedBox(width: 8),
                      Chip(
                        label: Text(clan.type),
                        backgroundColor: _getTypeColor(clan.type).withOpacity(0.2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'open':
        return Colors.green;
      case 'invite only':
        return Colors.orange;
      case 'closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildClanInfoCard(ClanModel clan) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clan Info', style: themeData.textTheme.titleMedium),
            Divider(),
            if (clan.description.isNotEmpty) ...[
              Text(
                clan.description,
                style: themeData.textTheme.bodyMedium,
              ),
              SizedBox(height: 12),
            ],
            _buildInfoRow(Icons.people, 'Members', '${clan.members}/50'),
            _buildInfoRow(Icons.emoji_events, 'Clan Trophies', '${clan.clanPoints}'),
            _buildInfoRow(Icons.military_tech, 'War Trophies', '${clan.clanVersusPoints}'),
            _buildInfoRow(Icons.trending_up, 'Required Trophies', '${clan.requiredTrophies}'),
            if (clan.warLeague.name.isNotEmpty)
              _buildInfoRow(Icons.workspace_premium, 'War League', clan.warLeague.name),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: themeData.primaryColor),
          SizedBox(width: 12),
          Expanded(child: Text(label, style: themeData.textTheme.bodyMedium)),
          Text(
            value,
            style: themeData.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildWarInfoCard(ClanModel clan) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('War Statistics', style: themeData.textTheme.titleMedium),
            Divider(),
            _buildInfoRow(Icons.schedule, 'War Frequency', clan.warFrequency),
            _buildInfoRow(Icons.local_fire_department, 'Win Streak', '${clan.warWinStreak}'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWarStat('Wins', clan.warWins, Colors.green),
                _buildWarStat('Ties', clan.warTies, Colors.orange),
                _buildWarStat('Losses', clan.warLosses, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarStat(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          '$value',
          style: themeData.textTheme.headlineSmall?.copyWith(color: color),
        ),
        Text(label, style: themeData.textTheme.bodySmall),
      ],
    );
  }

  Widget _buildLabelsCard(ClanModel clan) {
    if (clan.labels.isEmpty) return SizedBox.shrink();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Labels', style: themeData.textTheme.titleMedium),
            Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: clan.labels.map((label) {
                return Chip(
                  avatar: label.iconUrls.small.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: label.iconUrls.small,
                          errorWidget: (_, __, ___) => Icon(Icons.label, size: 18),
                        )
                      : Icon(Icons.label, size: 18),
                  label: Text(label.name),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersCard(ClanModel clan) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Members (${clan.members})', style: themeData.textTheme.titleMedium),
            Divider(),
            ...clan.memberList.map((member) => _buildMemberTile(member)),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberTile(MemberList member) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      leading: CircleAvatar(
        backgroundColor: _getRoleColor(member.role).withOpacity(0.2),
        child: Text(
          '${member.clanRank}',
          style: TextStyle(
            color: _getRoleColor(member.role),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(member.name, style: themeData.textTheme.bodyLarge),
      subtitle: Text(
        '${_formatRole(member.role)} • Level ${member.expLevel}',
        style: themeData.textTheme.bodySmall,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.emoji_events, size: 14, color: Colors.amber),
              SizedBox(width: 2),
              Text('${member.trophies}', style: themeData.textTheme.bodySmall),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.volunteer_activism, size: 14, color: Colors.green),
              SizedBox(width: 2),
              Text('${member.donations}', style: themeData.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'leader':
        return Colors.red;
      case 'coleader':
        return Colors.orange;
      case 'elder':
        return Colors.purple;
      case 'member':
      default:
        return Colors.blue;
    }
  }

  String _formatRole(String role) {
    if (role.isEmpty) return role;
    return role[0].toUpperCase() + role.substring(1);
  }
}

class ClanPageAppBar extends StatelessWidget with PrefAppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text('Clan'),
    );
  }
}
