import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String quote = "";
  String author = "";
  bool isLoading = false;
  String errorMessage = "";

  Future<void> fetchQuote() async {
  setState(() {
    isLoading = true;
    errorMessage = "";
  });

  try {
    final uri = Uri.parse('http://api.quotable.io/quotes/random');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List && data.isNotEmpty) {
        quote = data[0]["content"] ?? "No quote found";
        author = data[0]["author"] ?? "Unknown";
      } else if (data is Map) {
        quote = data["content"] ?? "No quote found";
        author = data["author"] ?? "Unknown";
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("HTTP ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching quote: $e");
    setState(() {
      errorMessage = "Failed to fetch quote: $e";
      quote = "";
      author = "";
    });
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Inspirational quotes"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : errorMessage.isNotEmpty
                    ? Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    : AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: quote.isEmpty ? 0.0 : 1.0,
                        child: Card(
                          color: Colors.white.withOpacity(0.85),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  quote.isEmpty
                                      ? "Press the button to get some wisdom ✨"
                                      : '"$quote"',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                if (author.isNotEmpty)
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "- $author",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: isLoading ? null : fetchQuote,
        backgroundColor: Colors.deepPurpleAccent,
        label: const Text(
          "Get Quote",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.format_quote_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
