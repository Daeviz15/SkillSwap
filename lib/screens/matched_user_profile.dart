import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skill_swap/widgets/app_colors.dart';

class MatchedUserProfile extends StatelessWidget {
  final String?
      matchedUserId; // Add this parameter to specify which user to display
  const MatchedUserProfile({this.matchedUserId, super.key});

  Future<Map<String, dynamic>> matchedSkills() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User is not logged in");

      // If matchedUserId is provided, fetch that specific user's data
      if (matchedUserId != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('ShareSkill')
            .doc(matchedUserId)
            .get();

        if (userDoc.exists) {
          final data = userDoc.data()!;
          return {
            'firstName': data['First_Name'],
            'lastName': data['Last_Name'],
            'description': data['Description'],
            'profileImage': data['User_Image'],
            'shareSkills': data['Share_Skill'] as List,
          };
        }
      }
    } catch (e) {
      print('Error fetching matching skills: $e');
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        titleTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: AppColors.primaryBlue,
          ),
        ),
        forceMaterialTransparency: true,
        title: const Text('Matched User Profile'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: matchedSkills(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitFadingCircle(
                  color: AppColors.primaryBlue,
                  size: 50.0,
                ),
              );
            }

            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No matched users found',
                  style: GoogleFonts.poppins(color: AppColors.primaryBlue),
                ),
              );
            }

            final userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (userData['profileImage'] != null &&
                      userData['profileImage'].isNotEmpty)
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(userData['profileImage']),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      '${userData['firstName']} ${userData['lastName']}',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Biography',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userData['description'] ?? 'No description available',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    '${userData['firstName']}\'s Skills:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (userData['shareSkills'] as List)
                        .map((skill) => Chip(
                              shape: const StadiumBorder(),
                              elevation: 5,
                              shadowColor:
                                  const Color.fromARGB(255, 24, 25, 26),
                              side: BorderSide.none,
                              label: Text(
                                skill,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  color: AppColors.primaryBlue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                              backgroundColor: Colors.white.withOpacity(0.1),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22, vertical: 8),
                          child: Row(children: [
                            Text(
                              'chat',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.chat,
                              color: Colors.green,
                              size: 14.0,
                            ),
                          ]),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Row(children: [
                            Text(
                              'Rate User',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.star,
                              color: Colors.yellowAccent,
                              size: 14.0,
                            ),
                          ]),
                        )),
                  ])
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
