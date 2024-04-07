import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor4you/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tutor4you/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:tutor4you/src/authentication/presentation/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is UserCreated) {
        getUsers();
      }
    }, builder: (context, state) {
      return Scaffold(
        body: state is GettingUsers
            ? const LoadingColumn(message: 'Getting Users')
            : state is CreatingUser
                ? const LoadingColumn(message: 'Creating Users')
                : state is UsersLoaded
                    ? Center(
                        child: ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return ListTile(
                              leading: Image.network(user.avatar),
                              title: Text(user.name),
                              subtitle: Text(user.createdAt.substring(10)),
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) =>
                  AddUserDialog(nameController: nameController),
            );
          },
          label: const Text('Add User'),
          icon: const Icon(Icons.add),
        ),
      );
    });
  }
}
