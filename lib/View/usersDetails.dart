import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:employees/Repository/usersDetailsRepo.dart';
import 'package:employees/Model/usersDetailsModel.dart';

class DetailScreen extends StatefulWidget {
  final String userId;
  final UsersDetailsRepo usersDetailsRepo;

  const DetailScreen({
    required this.userId,
    required this.usersDetailsRepo,
    Key? key,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<caseUsersDetails> getuserdetails;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    getuserdetails =
        fetchUserDetails(); // Fetch user details on screen initialization
  }

  Future<caseUsersDetails> fetchUserDetails() async {
    setState(() {
      isRefreshing = true;
    });

    try {
      final usersDetailsRepo = GetIt.I.get<UsersDetailsRepo>();
      final userDetails = await usersDetailsRepo.getUsersDetails(widget.userId);

      return userDetails;
    } catch (error) {
      rethrow;
    } finally {
      setState(() {
        isRefreshing = false;
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      isRefreshing = true;
    });

    try {
      await fetchUserDetails(); // Refresh user details when the refresh button is pressed
    } catch (error) {
      // Handle the error by showing an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(" $error"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Info"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go(
                '/'); // Navigate back one page when the back button is pressed
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isRefreshing ? null : _refreshData,
          ),
        ],
      ),
      body: FutureBuilder<caseUsersDetails>(
        future: getuserdetails,
        builder:
            (BuildContext context, AsyncSnapshot<caseUsersDetails> snapshot) {
          if (isRefreshing ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "An error occurred, try hitting refresh",
              ),
            );
          } else if (snapshot.hasData) {
            final usersList = snapshot.data!.data;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: usersList?.profileImage != null &&
                                usersList!.profileImage!.isNotEmpty
                            ? NetworkImage(usersList
                                .profileImage!) // Display user profile image if available
                            : null,
                        radius: 50,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Text(
                            "Employee Name",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text(
                            usersList?.employeeName != null &&
                                    usersList!.employeeName!.isNotEmpty
                                ? usersList
                                    .employeeName! // Display user's name if available
                                : 'N/A',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Text(
                            "Age",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text(
                            usersList?.employeeAge != null
                                ? usersList!.employeeAge!
                                    .toString() // Display user's age if available
                                : 'N/A',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(
                          child: Text(
                            "Salary",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text(
                            usersList?.employeeSalary != null
                                ? 'R ${usersList!.employeeSalary!}' // Display user's salary if available
                                : 'N/A',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text("No data available."));
          }
        },
      ),
    );
  }
}
