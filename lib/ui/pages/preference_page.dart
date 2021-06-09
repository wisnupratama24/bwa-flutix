part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;
  final List<String> genres = [
    'Horror',
    "Action",
    "Music",
    "Drama",
    "Crime",
    "War"
  ];
  final List<String> languages = [
    "English",
    "Indonesian",
    "Mandarin",
    "Korean"
  ];
  PreferencePage({Key key, this.registrationData}) : super(key: key);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenre = [];
  String language = "English";

  @override
  void initState() {
    super.initState();
    if (widget.registrationData.genre.isNotEmpty) {
      selectedGenre = widget.registrationData.genre;
      language = widget.registrationData.language;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(selectedGenre);

    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToRegistrationPage(
                                  widget.registrationData));
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Select Your\nFavorite Genre",
                    textAlign: TextAlign.left,
                    style: blackTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500, height: 1.5),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: generateGenre(context),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Movie Language\nYou Prefer",
                textAlign: TextAlign.left,
                style: blackTextFont.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w500, height: 1.5),
              ),
              SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: generateLanguage(context),
              ),
              SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                elevation: 0,
                backgroundColor: mainColor,
                onPressed: () {
                  if (selectedGenre.length < 1) {
                    _showFlash(
                        message: "Please select genre and language",
                        duration: Duration(seconds: 2));
                  } else {
                    widget.registrationData.genre = selectedGenre;
                    widget.registrationData.language = language;
                    context.read<PageBloc>().add(
                        GoToAccountConfirmationPage(widget.registrationData));
                  }
                },
                child: Icon(Icons.arrow_forward),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateGenre(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - (2 * defaultMargin) - 24) / 2;
    return widget.genres
        .map((e) => SelectableBox(
              text: e,
              width: width,
              isSelected: selectedGenre.contains(e),
              onTap: () => onSelectGenre(e),
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenre.contains(genre)) {
      setState(() {
        selectedGenre.remove(genre);
      });
    } else {
      if (selectedGenre.length < 4) {
        setState(() {
          selectedGenre.add(genre);
        });
      }
    }
  }

  List<Widget> generateLanguage(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - (2 * defaultMargin) - 24) / 2;
    return widget.languages
        .map((e) => SelectableBox(
              text: e,
              width: width,
              isSelected: e == language,
              onTap: () => {
                setState(() {
                  language = e;
                })
              },
            ))
        .toList();
  }

  void _showFlash({
    Duration duration,
    flashStyle = FlashBehavior.floating,
    String message,
  }) {
    showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          behavior: flashStyle,
          backgroundColor: pinkColor,
          position: FlashPosition.top,
          boxShadows: kElevationToShadow[0],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
