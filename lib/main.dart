import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

void main() {
  runApp(JDFApp());
}

class JDFApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JDF Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFF355E3B), // Green
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ProcessTimelinePage(),
    FAQPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _showFAQDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("FAQs"),
        content: Text("This section will be powered by ChatGPT or static answers."),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Close"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('JDF Enlistment Timeline') ,
        backgroundColor: Color(0xFF355E3B),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("JDF Recruit"),
              accountEmail: Text("recruit@jdf.mil.jm"),
              decoration: BoxDecoration(color: Color(0xFF355E3B)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/soldier.jpg'),
              ),
            ),
            ListTile(
              title: Text('Process'),
              leading: Icon(Icons.timeline),
              selected: _selectedIndex == 0,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
            ),
            ListTile(
              title: Text('FAQs'),
              leading: Icon(Icons.help_outline),
              selected: _selectedIndex == 1,
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(1);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 3),
      ),

        height: 56,
        width: 56,
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: _showFAQDialog,
          child: ClipOval(
            child: Image.asset(
              'assets/soldier.jpg',
              fit: BoxFit.cover,
              height: 56,
              width: 56,
            ),
          ),
        ),
      ),

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xFF355E3B),
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'Process'),
          BottomNavigationBarItem(icon: Icon(Icons.help_outline), label: 'FAQs'),
        ],
      ),
    );
  }
}

class ProcessTimelinePage extends StatelessWidget {
  final List<Map<String, dynamic>> steps = [
    {
      "title": "Pre-Attestation",
      "status": "Passed",
      "time": "8:30 AM",
      "desc": "Submitted documents and ID verification",
    },
    {
      "title": "Entrance Exam",
      "status": "Passed",
      "time": "9:30 AM",
      "desc": "Math, English, and General Knowledge",
    },
    {
      "title": "Reading & Dictation",
      "status": "Passed",
      "time": "11:00 AM",
      "desc": "Reading and writing test",
    },
    {
      "title": "Psychometric Test",
      "status": "Passed",
      "time": "12:00 PM",
      "desc": "Personality and logic evaluation",
    },
    {
      "title": "First Medical (Blood Test)",
      "status": "Under Review",
      "time": "2:30 PM",
      "desc": "Awaiting review of test results",
    },
    {
      "title": "Physical Fitness Test",
      "status": "Denied",
      "time": "",
      "desc": "1.5-mile run, push-ups, sit-ups",
    },
    {
      "title": "X-Ray",
      "status": "Pending",
      "time": "",
      "desc": "Spinal and chest evaluation",
    },
    {
      "title": "Final Medical",
      "status": "Pending",
      "time": "",
      "desc": "Comprehensive medical review",
    },
    {
      "title": "Dental Review",
      "status": "Pending",
      "time": "",
      "desc": "Check teeth, gums, and oral hygiene",
    },
    {
      "title": "Credibility Test",
      "status": "Pending",
      "time": "",
      "desc": "Background and behavior screening",
    },
    {
      "title": "Security Vetting",
      "status": "Pending",
      "time": "",
      "desc": "Police and community check",
    },
    {
      "title": "Attestation Ceremony",
      "status": "Pending",
      "time": "",
      "desc": "Final oath and acceptance",
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Passed':
        return Color(0xFF355E3B);
      case 'Pending':
        return Colors.grey;
      case 'Under Review':
        return Colors.black;
      case 'Denied':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Passed':
        return Icons.check;
      case 'Pending':
        return Icons.hourglass_empty;
      case 'Under Review':
        return Icons.search;
      case 'Denied':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final step = steps[index];
        final isFirst = index == 0;
        final isLast = index == steps.length - 1;

        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: LineStyle(
            color: getStatusColor(step['status']),
            thickness: 2,
          ),
          indicatorStyle: IndicatorStyle(
            width: 30,
            color: getStatusColor(step['status']),
            iconStyle: IconStyle(
              iconData: getStatusIcon(step['status']),
              color: Colors.white,
            ),
          ),
          endChild: Container(
            margin: EdgeInsets.only(left: 16, bottom: 24),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step['title'],
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                if (step['time'] != "")
                  Text("Time: ${step['time']}", style: TextStyle(fontSize: 12)),
                Text("Notes: ${step['desc']}", style: TextStyle(fontSize: 13)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      label: Text(
                        step['status'],
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: getStatusColor(step['status']),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage('assets/soldier.jpg'),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {"Q": "What is the age limit?", "A": "17 to 23 years old."},
    {"Q": "Do I need subjects?", "A": "Yes, English and Math are required."},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        final faq = faqs[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text("Q: ${faq["Q"]}",
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child:
              Text("A: ${faq["A"]}", style: TextStyle(color: Colors.black)),
            ),
          ),
        );
      },
    );
  }
}
