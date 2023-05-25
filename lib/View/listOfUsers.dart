import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:employees/Model/listOfUsersModel.dart';
import 'package:employees/Repository/usersRepo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<ListOfUsers>? _usersListFuture; // Future that holds the list of users
  bool _isLoading = false; // Flag to track if data is being loaded

  @override
  void initState() {
    super.initState();
    _fetchUsersList(); // Fetch the list of users when the page is initialized
  }

  Future<void> _fetchUsersList() async {
    setState(() {
      _isLoading = true; // Set isLoading flag to true when fetching data
    });

    try {
      final usersRepo =
          GetIt.I.get<UsersRepo>(); // Get the UsersRepo instance using GetIt
      final listOfUsers = await usersRepo
          .getUsers(); // Fetch the list of users from the repository

      setState(() {
        _usersListFuture = Future.value(
            listOfUsers); // Set the fetched list of users to the Future
      });
    } catch (error) {
      setState(() {
        _usersListFuture = Future.error(
            error.toString()); // Set an error message if fetching fails
      });
    } finally {
      setState(() {
        _isLoading =
            false; // Set isLoading flag to false when fetching is done (success or failure)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading
                ? null
                : _fetchUsersList, // Disable refresh button when data is loading
          ),
        ],
      ),
      body: FutureBuilder<ListOfUsers?>(
        future:
            _usersListFuture, // The Future to build the UI based on its state
        builder: (BuildContext context, AsyncSnapshot<ListOfUsers?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator while waiting for data
          }
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator when there is no connection state
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  "${snapshot.error}, try hitting refresh"), // Show an error message if there is an error in fetching data
            );
          } else if (snapshot.hasData) {
            final usersList =
                snapshot.data!; // Extract the ListOfUsers from the snapshot
            return ListView.builder(
              itemCount: usersList.data!.length, // Number of items in the list
              itemBuilder: (BuildContext context, int index) {
                final user =
                    usersList.data![index]; // Get a user at the current index
                return buildUserCard(
                    user); // Build a user card widget for the user
              },
            );
          } else {
            return const Center(
                child: Text(
                    "No data available.")); // Show a message when there is no data
          }
        },
      ),
    );
  }

  Widget buildUserCard(user) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: () {
          GoRouter.of(context).go(
              '/detail/${user.id}'); // Handle tap event to navigate to user detail page
        },
        title: Text(
          "Name: ${user.employeeName ?? 'N/A'}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user.employeeAge != null && user.employeeAge != "")
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Employee Age: ${user.employeeAge}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              if (user.employeeSalary != null && user.employeeSalary != "")
                Text(
                  "Employee Salary: ${user.employeeSalary}",
                  style: const TextStyle(fontSize: 14),
                ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.remove_red_eye),
          onPressed: () {
            GoRouter.of(context).go(
                '/detail/${user.id}'); // Handle button press to navigate to user detail page
          },
        ),
      ),
    );
  }
}
