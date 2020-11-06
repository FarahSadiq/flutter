import 'package:flutter/material.dart';
import 'package:flutter_app_2/model/movie.dart';
import 'package:flutter_app_2/model/question.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List questions = [
    Question.name("Question 1", true),
    Question.name("Question 2 sfs rftdh turtjuyr", true),
    Question.name("Question 3", false),
  ];
  int _current = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        //key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Quiz App"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        backgroundColor: Colors.deepPurpleAccent,
        body: new Builder(builder: (BuildContext context)  {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset("images/wordcloud.jpg",
                      width: 250,
                      height: 180,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                              color: Colors.blueGrey.shade300,
                              style: BorderStyle.solid
                          )
                      ),
                      height: 120,
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: (
                                Text(questions[_current].text,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),))
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(onPressed: () => _checkAnswer(true,context),
                        color: Colors.deepPurple,
                        child: Text("True"),
                      ),
                      RaisedButton(onPressed: () => _checkAnswer(false,context),
                        color: Colors.deepPurple,
                        child: Text("False"),
                      ),
                      RaisedButton(onPressed: () => _nextQues(),
                        color: Colors.deepPurple,
                        child: Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                  Spacer(),
                ],

              ),
            );
          }
        )
    );
  }
  _checkAnswer(userSelection,BuildContext context) {
    if (userSelection == questions[_current].isCorrect) {
      final snackbar = SnackBar(content: Text('Correct Answer!'),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500));
      Scaffold.of(context).showSnackBar(snackbar);
    }
    else {
      final snackbar = SnackBar(content: Text('Inorrect Answer!'),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 500));
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  _nextQues() {
    setState(() {
      _current = (_current + 1) % questions.length;
    });
  }
}

class MovieList extends StatelessWidget {
  @override
  final List<Movie> movies = Movie.getMovies();
  // final list = [
  //   "Inception",
  //   "mission Impossible",
  //   "Now you see me",
  //   "Catch me if you can",
  //   "Spiderman",
  //   "The Dark Knight"
  // ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.grey.shade900,
      body: ListView.builder(
        itemCount: movies.length,
          itemBuilder: (BuildContext context, int index){
          return Stack(children: [
            Positioned(child: getCard(movies[index],context)),
              Positioned(
                top: 10,
                  child: movieImage(movies[index].images[1])),

          ],
          );
        // return Card(
        //   color: Colors.white,
        //   elevation: 4.5,
        //   child: ListTile(
        //     leading: CircleAvatar(
        //       child: Container(
        //         width: 300,
        //         height: 300,
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             image: NetworkImage(movies[index].images[1]),
        //             fit: BoxFit.cover,
        //           ),
        //           borderRadius: BorderRadius.circular(20)
        //         ),
        //       ),
        //     ),
        //     title: Text(movies[index].name),
        //     onTap: (){
        //       Navigator.push(context, MaterialPageRoute(
        //           builder:(context) => MovieDetails(movie: movies[index],)));
        //     },
        //   ),
        // );
      }),
    );
  }
    Widget getCard(Movie movie, BuildContext context){
      return InkWell(
        child: Container(
          margin: EdgeInsets.only(left: 60),
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Card(
            color: Colors.black26,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,
              bottom: 8.0,
              left: 54.0,
              right: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(movie.name,style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white54
                        ),),
                        Text("Rating: "+movie.imdbRating,style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Released: "+movie.released),
                        Text(movie.rutTime),
                        Text(movie.rated),
                      ],
                    )
                  ],

                ),
              ),
            ),
          ),
        ),
      onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:(context) => MovieDetails(movie: movie,)));
           },
      );
    }
Widget movieImage(String imageUrl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? 'https://i.picsum.photos/id/107/200/300.jpg?hmac=vq69VuAP_HhH4bpPD0bOs_QN_b-223QZ6RKKdu-Vv_I'),
          fit: BoxFit.cover
        )
      ),

    );
}
}
class MovieDetails extends StatelessWidget {
  @override
  //final String movieName;
  final Movie movie;

  const MovieDetails({Key key, this.movie}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          MovieThumbnail(thumbnail:movie.images[1]),
          HeaderWithPoster(movie: movie,),
          HorizontalLine(),
          MovieExtraPosters(posters: movie.images,)
        ],
      ),
      // body: Container(
      //
      //   child: Center(
      //     child: RaisedButton(
      //       child: Text(movie.director),
      //       color: Colors.lightBlue,
      //       onPressed: () => Navigator.pop(context),
      //     ),
      //   ),
      // ),
    );
  }
}
class MovieThumbnail extends StatelessWidget {
  @override
  final String thumbnail;

  MovieThumbnail({this.thumbnail});

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
                height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover
                )
              ),
            ),
            Icon(Icons.play_circle_outline,
            size: 100,
            color: Colors.white,)
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0x00f5f5f5),Color(0xfff5f5f5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
      ),
          ),
          height: 70,
        )
      ],
    );
  }
}
class HeaderWithPoster extends StatelessWidget {
  @override
  final Movie movie;

  const HeaderWithPoster({Key key, this.movie}) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[2],),
          SizedBox(
            width: 16,),
          Flexible(child: MovieHeader(movie: movie,)),
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  @override
  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width/4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover
            )
          ),
        ),
      ),
    );
  }
}
class MovieHeader extends StatelessWidget {
  @override
  final Movie movie;

  const MovieHeader({Key key, this.movie}) : super(key: key);
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(movie.year.toUpperCase()+' . '+ movie.genre.toUpperCase(),
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.w400
        ),),
        Text(movie.name,
            style: TextStyle(
            fontWeight: FontWeight.w500,
              fontSize: 20
        )
        ),
        Text.rich(TextSpan(
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400
            ),
          children: <TextSpan>[
            TextSpan(
              text: movie.plot
            ),
            TextSpan(
                text: "more...",
                style: TextStyle(
                    color: Colors.blue
                )
            )
          ]
        )
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}
class MovieExtraPosters extends StatelessWidget {
  @override
  final List<String> posters;

  const MovieExtraPosters({Key key, this.posters}) : super(key: key);
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text("More movie posters"),
        Container(
          height: 200,
          child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: posters.length,
    separatorBuilder: (context,index) => SizedBox(width: 8,),
    itemBuilder: (context,index) => ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    child: Container(
    width: MediaQuery.of(context).size.width/4,
    height: 180,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: NetworkImage(posters[index],),
    fit: BoxFit.cover
    )
    ),
    ),
    ),

          ),
        )
      ],
    );
  }
}

class Invitation extends StatefulWidget {
  @override
  _InvitationState createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
  @override
  final events = [{
    "event": "Barat",
    "date": "11-12-2020",
    "day": "Friday",
    "venue":"Gloriosa Banquet, C-42, Block 15, Gulistan-e-Johar Near Continental Bakery Karachi",
    "Timing":"7 P.M-10 P.M"
  },
    {
      "event": "Valima",
      "date": "13-12-2020",
      "day": "Sunday",
      "venue":"Faran Club, St 1/A, Sir Shah Suleman Road, Block 15, Gulshan-e-Iqbal Karachi",
      "Timing":"7 P.M-10 P.M"
    }];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wedding Invitation"),
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          Positioned(
            left: 120,
            child: Text("Hamza & Farah",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent,
              fontStyle: FontStyle.italic,
            ),),
          ),
          Positioned(

              child:getCard(context))
        ],
      )
      
    );
  }
  Widget getCard(context){
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.deepPurpleAccent,
              child: Column(
                children: [
                  Center(child: Text(events[index]['event'].toUpperCase(),style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                    fontStyle: FontStyle.italic,

                  )),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.calendar_today,color: Colors.red.shade900),
                      ),
                      Text(events[index]['date'])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.alarm,color: Colors.red.shade900),
                      ),
                      Text(events[0]['Timing'])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.account_balance,color: Colors.red.shade900),
                      ),
                      Flexible(child: Text(events[index]['venue']))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
