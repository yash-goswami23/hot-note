import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_note/bloc/auth/auth_bloc.dart';
import 'package:hot_note/bloc/home/home_bloc.dart';
import 'package:hot_note/core/common/custom_button.dart';
import 'package:hot_note/core/common/loader.dart';
import 'package:hot_note/core/common/task_card.dart';
import 'package:hot_note/core/routes/app_routes.dart';
import 'package:hot_note/core/theme/app_colors.dart';
import 'package:hot_note/core/utils/show_toast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.w500)),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(CheckIsAuthenticated());
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      alignment: Alignment.center,
                      title: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthSuccess) {
                            return Text(
                              "${state.user!.email} You want to Logout? ",
                              style: TextStyle(fontSize: 22),
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Loader();
                          }
                        },
                      ),
                      actions: [
                        SizedBox(
                          width: 100,
                          child: CstmBtn(
                            txt: "Yes",
                            onTap: () {
                              context.read<AuthBloc>().add(Logout());
                              context.go(AppRoutes.auth);
                            },
                          ),
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
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        scrolledUnderElevation: 0,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          print("HomeDegub: state: $state");
          if (state is HomeInitial) {
            context.read<HomeBloc>().add(GetNotesEvent());
          } else if (state is HomeFailure) {
            showToast(context: context, msg: state.msg);
          }
        },
        builder: (context, state) {
          if (state is HomeInitial) {
            context.read<HomeBloc>().add(GetNotesEvent());
          }
          if (state is HomeSuccess) {
            print("HomeDegub: stateSuccess: ${state.notes}");

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.notes.length,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: ShowNoteCard(
                            onTap: () {},
                            note: state.notes[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("Add Some Notes"));
          }
        },
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
