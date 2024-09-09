
import 'package:flutter/material.dart';


class SearchBarApp extends StatefulWidget {
  final String searchHintText;
  const SearchBarApp({super.key, required this.searchHintText});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {

   return  Center(
     child: SizedBox(
       width: MediaQuery.of(context).size.width - 40,
       child: Material(
         elevation: 3,
         borderRadius: BorderRadius.circular(14),
         child: Container(
           decoration: BoxDecoration(
             color: Colors.grey[300],
             borderRadius: BorderRadius.circular(14),
             boxShadow: [
               BoxShadow(
                 color: Colors.black.withOpacity(0.1),
                 blurRadius: 20,
                 offset: const Offset(0, 5),
               ),
             ],
           ),
           child: TextFormField(
             decoration: InputDecoration(
               prefixIcon: const Icon(Icons.search_sharp),
               hintText: 'Search, ${widget.searchHintText}',
               enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(14),
                 borderSide: const BorderSide(
                     color: Colors.transparent), // Make enabled border transparent
               ),
               focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(14),
                 borderSide: const BorderSide(
                   color: Colors.transparent, // Make focused border transparent
                   width: 2,
                 ),
               ),
               filled: true,
               fillColor: Colors.white.withOpacity(0.7), // Slightly transparent white background
             ),
             onChanged: (value) {
               // Handle search query changes
             },
           ),
         ),
       ),
     ),
   );
  }
}
