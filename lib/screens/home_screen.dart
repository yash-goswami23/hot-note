import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_note/core/common/custom_button.dart';
import 'package:hot_note/core/common/task_card.dart';
import 'package:hot_note/core/routes/app_routes.dart';
import 'package:hot_note/core/theme/app_colors.dart';
import 'package:hot_note/data/models/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Task> task = [
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),

      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),

      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),

      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),

      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),

      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
      ),
      Task(
        id: "01",
        title: "This is Title",
        desc: "I want to compelete this task at 30 hours",
        isUploaded: true,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.w500)),
        actions: [
          IconButton(
            onPressed:
                () => showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        alignment: Alignment.center,
                        title: Text(
                          "You want to Logout?",
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          SizedBox(
                            width: 100,
                            child: CstmBtn(txt: "Yes", onTap: () {}),
                          ),
                          SizedBox(width: 5),
                          SizedBox(
                            width: 100,
                            child: CstmBtn(
                              txt: "No",
                              onTap: () {
                                context.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                ),
            icon: Icon(Icons.logout),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: task.length,
                padding: EdgeInsets.symmetric(vertical: 12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: ShowTaskCard(onTap: () {}, task: task[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addNote),
        elevation: 2,
        child: Icon(Icons.add, color: AppColors.textPrimary),
      ),
    );
  }
}
