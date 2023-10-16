# API App for crowler fussball.de

The application goes to Fussball.de and provides you with the next and past match of your club or team.


# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://localhost:8080/api/club/next_games/00ES8GN91400002IVV0AG08LVUPGND5I
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:08.392928  0:00:00.201216 GET     [200] /api/club/next_games/00ES8GN91400002IVV0AG08LVUPGND5I
```

## Debug Mode

```
dart run --observe  bin/server.dart 
```


