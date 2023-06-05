import 'package:flutter/material.dart';
import 'dashboard_view.dart';
import 'portfolio_view.dart';
import 'user_info_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabTitles = [
    'Dashboard',
    'Portfolio',
    'User Info'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {}); // Update the title when tab is changed
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.94,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/login_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                  height: 40), // Spacer for top margin
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Dashboard(), // Dashboard Tab Content
                    Portfolio(), // Portfolio Tab Content
                    UserInfo(
                        context:
                            context), // User Info Tab Content
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(
                        0.7), //Opacity of the tab bar
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20),
                    child: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          text: 'Dashboard',
                          icon: Icon(Icons.dashboard),
                        ),
                        Tab(
                          text: 'Portfolio',
                          icon: Icon(Icons.folder),
                        ),
                        Tab(
                          text: 'User Info',
                          icon: Icon(Icons.person),
                        ),
                      ],
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor:
                          Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
