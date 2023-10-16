# API App for crowler fussball.de

The application goes to Fussball.de and provides you with the next and past match of your club or team.


# Running 

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
dart run --observe bin/server.dart 
```

# For Pull Request

Before you make a pull request, please run the following commands:

```
dart test -j 1
dart fix --dry-run
dart analyze
```

And check that everything is ok.

# Test

In dart the test pairs were started, that with the DB can cause certain problems, therefore we start test only with a process.

```
dart test -j 1
```


