import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget{
  final String title;
  final String description;
  final bool isFavorite;

  const DescriptionPage({
    super.key,
    required this.title,
    required this.description,
    required this.isFavorite
  });

  @override
  State<DescriptionPage> createState() => _DesciptionPageState();
}

class _DesciptionPageState extends State<DescriptionPage> {
  late bool _isFavorite;
  @override
  void initState(){
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleImportant() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).dividerColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(_isFavorite),
         icon: Icon(Icons.arrow_back)),
      actions: [
        IconButton(
          icon: Icon(
              _isFavorite ? Icons.star : Icons.star_border,
              size: 28,
            ),
            onPressed: _toggleImportant,
          ),
          const SizedBox(width: 10),
        ],
      ),
      extendBodyBehindAppBar: true, 
      body: WillPopScope(
        onWillPop: () async{
          Navigator.of(context).pop(_isFavorite);
          return false;
        },
      child: Container(
        color: Theme.of(context).dividerColor,
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20), 
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Icon(Icons.short_text_rounded, size: 20),
                  SizedBox(width: 8),
                  Text('세부 내용은 다음과 같습니다.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  widget.description.isEmpty 
                    ? '세부 내용은 여기에 작성합니다.'
                    : widget.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
   );
  }
}
     