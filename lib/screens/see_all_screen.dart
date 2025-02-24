import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_swap/screens/matched_user_profile.dart';
import 'package:skill_swap/state_management/user_skill_provider.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF2196F3); // Main blue color
    final skillsProvider =
        Provider.of<UserSkillProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w800, fontSize: 18, color: primaryBlue),
        ),
        forceMaterialTransparency: true,
        title: const Text('All Matched Users'),
      ),
      backgroundColor: const Color.fromARGB(255, 226, 242, 250),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: skillsProvider.matchSkills(),
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitFadingCircle(
                  color: primaryBlue,
                  size: 50.0,
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading matched users'),
              );
            }

            final List snapCount = snapshot.data ?? [];
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  scrollDirection: Axis.vertical,
                  itemCount: snapCount.length,
                  itemBuilder: (ctx, int index) {
                    final snapDataIndex = snapCount[index];
                    final matchedSkills =
                        (snapDataIndex['matchingSkills'] as List)
                            .take(3)
                            .toList();
                    final allSkills =
                        (snapDataIndex['allSkills'] as List).toList();

                    return Container(
                      // Reduced from 0.9
                      margin: const EdgeInsets.symmetric(
                          vertical: 20.0), // Increased from 23.0
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20), // Added extra spacing
                          CircleAvatar(
                              radius: 30,
                              backgroundImage: ResizeImage(
                                width: 120,
                                height: 120,
                                NetworkImage(snapDataIndex['Profile_Image']),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width *
                                0.63, // Reduced from 0.8
                            height: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 226, 242, 250),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  snapDataIndex['FirstName'] +
                                          ' ' +
                                          snapDataIndex['LastName'] ??
                                      'Unknown User',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: primaryBlue,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Matched skills',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: primaryBlue,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    matchedSkills.join(', '),
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: primaryBlue,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (ctx) {
                                          return Container(
                                            height: 300,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 226, 242, 250),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 20),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  snapDataIndex['FirstName'] +
                                                          ' ' +
                                                          snapDataIndex[
                                                              'LastName'] ??
                                                      'This user hasn\'t told us his name yet😀',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        color: primaryBlue,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Text(
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              color:
                                                                  primaryBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 12),
                                                    ),
                                                    'This user has ${allSkills.length} skills:'),
                                                const SizedBox(height: 20),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  allSkills.join(','),
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        color: primaryBlue,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: primaryBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 35, vertical: 5),
                                      child: Text(
                                        'see all',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 25), // Increased from 15
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 22, vertical: 8),
                                        child: Row(children: [
                                          Text(
                                            'chat',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  color: Color(0xFF5DACDE),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Icons.chat,
                                            color: primaryBlue,
                                            size: 14.0,
                                          ),
                                        ]),
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) {
                                        return MatchedUserProfile(
                                          matchedUserId: snapDataIndex['uid'],
                                        );
                                      }));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          child: Row(children: [
                                            Text(
                                              'view profile',
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    color: Color(0xFF5DACDE),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Icon(
                                              Icons.person_3_rounded,
                                              color: primaryBlue,
                                              size: 14.0,
                                            ),
                                          ]),
                                        )),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                              height: 20), // Added extra bottom spacing
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
