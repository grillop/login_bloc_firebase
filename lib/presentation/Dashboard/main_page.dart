import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gh_recipes/presentation/Dashboard/profile.dart';
import 'package:gh_recipes/presentation/Dashboard/recipes.dart';
import '../../bloc/bloc/auth_bloc.dart';
import '../SignIn/sign_in.dart';
import 'beverages.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [const Recipes(), const Beverages(), const Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Food')),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(
          //     Icons.search,
          //     semanticLabel: 'search',
          //   ),
          //   onPressed: () {
          //     print('Search button');
          //   },
          // ),
          IconButton(
            icon: const Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              print('Filter button');
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
            label: "Recipes", icon: Icon(Icons.local_dining)),
        BottomNavigationBarItem(
            label: "Beverages", icon: Icon(Icons.local_bar)),
        BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
      ]),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/good_food_display.jpg'),
                ElevatedButton(
                  child: const Text('Sign Out'),
                  onPressed: () {
                    // Signing out the user
                    context.read<AuthBloc>().add(SignOutRequested());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
