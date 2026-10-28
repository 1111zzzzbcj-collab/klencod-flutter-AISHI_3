import 'package:flutter/material.dart';

void main() {
  runApp(const AishiApp());
}

class AishiApp extends StatelessWidget {
  const AishiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AISHI',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1220),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF35D6A4),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      home: const AishiHome(),
    );
  }
}

class AishiHome extends StatefulWidget {
  const AishiHome({super.key});

  @override
  State<AishiHome> createState() => _AishiHomeState();
}

class _AishiHomeState extends State<AishiHome> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'أحمد',
      'message': 'السلام عليكم 👋',
      'time': '10:30',
      'color': Color(0xFF4385F5),
      'unread': 2,
    },
    {
      'name': 'محمد',
      'message': 'كيف حالك؟',
      'time': '09:45',
      'color': Color(0xFF9C6ADE),
      'unread': 0,
    },
    {
      'name': 'سارة',
      'message': 'تمام، شكرًا ❤️',
      'time': 'أمس',
      'color': Color(0xFFE86F9B),
      'unread': 1,
    },
    {
      'name': 'خالد',
      'message': 'أراك لاحقًا',
      'time': 'أمس',
      'color': Color(0xFFE5A34D),
      'unread': 0,
    },
  ];

  final List<Map<String, dynamic>> contacts = [
    {'name': 'أحمد', 'color': Color(0xFF4385F5)},
    {'name': 'محمد', 'color': Color(0xFF9C6ADE)},
    {'name': 'سارة', 'color': Color(0xFFE86F9B)},
    {'name': 'خالد', 'color': Color(0xFFE5A34D)},
    {'name': 'علي', 'color': Color(0xFF35D6A4)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        title: const Row(
          children: [
            Icon(Icons.forum_rounded, color: Color(0xFF35D6A4), size: 29),
            SizedBox(width: 10),
            Text(
              'AISHI',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: AishiSearch(chats),
              );
            },
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            onPressed: _showAbout,
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          _buildChats(),
          _buildStatuses(),
          _buildContacts(),
          _buildSettings(),
        ],
      ),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF35D6A4),
              foregroundColor: const Color(0xFF0B1220),
              onPressed: _newChat,
              child: const Icon(Icons.edit_rounded),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF111C2E),
        indicatorColor: const Color(0xFF254B48),
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            selectedIcon: Icon(Icons.chat_bubble_rounded),
            label: 'المحادثات',
          ),
          NavigationDestination(
            icon: Icon(Icons.circle_outlined),
            selectedIcon: Icon(Icons.circle),
            label: 'الحالات',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline_rounded),
            selectedIcon: Icon(Icons.people_rounded),
            label: 'الأصدقاء',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }

  Widget _buildChats() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'مرحبًا بك 👋',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text(
          'تواصل مع من تحب، في أي وقت.',
          style: TextStyle(color: Colors.white60, fontSize: 14),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          decoration: BoxDecoration(
            color: const Color(0xFF142237),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, color: Color(0xFF35D6A4)),
              SizedBox(width: 10),
              Text('ابحث عن محادثة', style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'آخر المحادثات',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...chats.map((chat) => _chatTile(chat)),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'AISHI • تواصل بلا حدود',
            style: TextStyle(color: Colors.white30, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _chatTile(Map<String, dynamic> chat) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatPage(
              name: chat['name'],
              color: chat['color'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: chat['color'],
              child: Text(
                chat['name'][0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    chat['message'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat['time'],
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 7),
                if (chat['unread'] > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF35D6A4),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${chat['unread']}',
                      style: const TextStyle(
                        color: Color(0xFF0B1220),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatuses() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'الحالات',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'شارك لحظاتك مع أصدقائك.',
          style: TextStyle(color: Colors.white60),
        ),
        const SizedBox(height: 25),
        ListTile(
          leading: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFF183A39),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.add, color: Color(0xFF35D6A4)),
          ),
          title: const Text('حالتي'),
          subtitle: const Text('أضف حالة جديدة'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('سنضيف نشر الحالات في المرحلة القادمة')),
            );
          },
        ),
        const Divider(color: Colors.white12, height: 30),
        const Center(
          child: Text(
            'لا توجد حالات جديدة حاليًا',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      ],
    );
  }

  Widget _buildContacts() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'الأصدقاء',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'تعرّف على أصدقائك وابدأ محادثة.',
          style: TextStyle(color: Colors.white60),
        ),
        const SizedBox(height: 20),
        ...contacts.map(
          (contact) => ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: contact['color'],
              child: Text(
                contact['name'][0],
                style: const TextStyle(fontSize: 21, color: Colors.white),
              ),
            ),
            title: Text(contact['name']),
            subtitle: const Text('مستخدم تجريبي'),
            trailing: IconButton(
              icon: const Icon(
                Icons.chat_rounded,
                color: Color(0xFF35D6A4),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      name: contact['name'],
                      color: contact['color'],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettings() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'الإعدادات',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        const CircleAvatar(
          radius: 42,
          backgroundColor: Color(0xFF183A39),
          child: Icon(
            Icons.person_rounded,
            size: 48,
            color: Color(0xFF35D6A4),
          ),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            'مستخدم AISHI',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Center(
          child: Text(
            'لم تسجّل الدخول بعد',
            style: TextStyle(color: Colors.white54),
          ),
        ),
        const SizedBox(height: 25),
        _settingTile(Icons.person_outline, 'الحساب', 'إدارة ملفك الشخصي'),
        _settingTile(Icons.lock_outline, 'الخصوصية', 'التحكم في خصوصيتك'),
        _settingTile(Icons.notifications_none, 'الإشعارات', 'تنبيهات الرسائل'),
        _settingTile(Icons.palette_outlined, 'المظهر', 'ألوان التطبيق'),
        _settingTile(Icons.info_outline, 'حول التطبيق', 'AISHI الإصدار 1.0.0',
            onTap: _showAbout),
      ],
    );
  }

  Widget _settingTile(
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xFF183A39),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: const Color(0xFF35D6A4)),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: Colors.white38),
      onTap: onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('سنضيف ميزة $title لاحقًا')),
            );
          },
    );
  }

  void _newChat() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF142237),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'ابدأ محادثة جديدة',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            ...contacts.map(
              (contact) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: contact['color'],
                  child: Text(contact['name'][0]),
                ),
                title: Text(contact['name']),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    this.context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        name: contact['name'],
                        color: contact['color'],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: 'AISHI',
      applicationVersion: '1.0.0',
      applicationLegalese: 'تواصل بلا حدود\n© 2026 AISHI',
      children: const [
        SizedBox(height: 12),
        Text('صاحب المشروع: خالد الشامي'),
      ],
    );
  }
}

class ChatPage extends StatefulWidget {
  final String name;
  final Color color;

  const ChatPage({
    super.key,
    required this.name,
    required this.color,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();
  final List<String> messages = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() => messages.add(text));
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111C2E),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.color,
              child: Text(widget.name[0]),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: const TextStyle(fontSize: 16)),
                const Text(
                  'محادثة تجريبية',
                  style: TextStyle(fontSize: 11, color: Colors.white54),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 55,
                          color: Color(0xFF35D6A4),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'ابدأ المحادثة 👋',
                          style: TextStyle(color: Colors.white60),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(13),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFF176B57),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                          child: Text(messages[index]),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالة...',
                        filled: true,
                        fillColor: const Color(0xFF142237),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF35D6A4),
                      foregroundColor: const Color(0xFF0B1220),
                    ),
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AishiSearch extends SearchDelegate<String> {
  final List<Map<String, dynamic>> chats;

  AishiSearch(this.chats);

  @override
  String get searchFieldLabel => 'ابحث عن شخص...';

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, ''),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => _results();

  @override
  Widget buildSuggestions(BuildContext context) => _results();

  Widget _results() {
    final results = chats.where((chat) {
      return chat['name'].toString().contains(query) ||
          chat['message'].toString().contains(query);
    }).toList();

    if (results.isEmpty) {
      return const Center(child: Text('لا توجد نتائج'));
    }

    return ListView(
      children: results.map((chat) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: chat['color'],
            child: Text(chat['name'][0]),
          ),
          title: Text(chat['name']),
          subtitle: Text(chat['message']),
        );
      }).toList(),
    );
  }
}