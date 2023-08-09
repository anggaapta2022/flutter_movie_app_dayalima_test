// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());
  List currentData = [];
  int currentPage = 1;

  Future<dynamic> getMovies() async {
    try {
      if (state is MovieInitial) {
        emit(MovieLoading());
        final response = await http.get(Uri.parse(
            'https://dlabs-test.irufano.com/api/movie?size=10&page=1'));
        var data = jsonDecode(response.body);
        for (var item in data['data']) {
          if (item['poster'] ==
              "https://m.media-amazon.com/images/M/MV5BOTU5NjVkN2YtNmFjZS00MzhjLWI0MGMtZjE3ZmE1OTc0ZjczXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg") {
            item['poster'] = null;
          }
        }
        if (response.statusCode == 200) {
          emit(MovieSuccess(data['data'], false));
          print("berhasil yang pertama");
          currentPage++;
        } else {
          emit(MovieFailure("Failed to get movies"));
        }
      } else {
        print("ambil current page selanjutnya");
        final response = await http.get(Uri.parse(
            'https://dlabs-test.irufano.com/api/movie?size=10&page=$currentPage'));
        var data = jsonDecode(response.body);
        for (var item in data['data']) {
          if (item['poster'] ==
              "https://m.media-amazon.com/images/M/MV5BOTU5NjVkN2YtNmFjZS00MzhjLWI0MGMtZjE3ZmE1OTc0ZjczXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg") {
            item['poster'] = null;
          }
        }
        if (response.statusCode == 200) {
          MovieSuccess movieSuccess = state as MovieSuccess;
          emit(data['data'].isEmpty
              ? MovieSuccess(movieSuccess.dataMovie, true)
              : MovieSuccess(movieSuccess.dataMovie + data['data'], false));
          currentPage++;
          print("isi movie: ${movieSuccess.dataMovie}");
        } else {
          emit(MovieFailure("Failed to get movies"));
        }
      }
    } catch (e) {
      print("isi error: $e");
      emit(MovieFailure("Failed to get movies"));
    }
  }

  Future<dynamic> insertMovies(
      String movieName, String descriptionMovies, String imagePath) async {
    try {
      emit(MovieLoading());
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://dlabs-test.irufano.com/api/movie'))
        ..fields.addAll({
          'title': movieName,
          'description': descriptionMovies,
        });
      request.files.add(await http.MultipartFile.fromPath('poster', imagePath));
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Berhasil insert");
        emit(MovieInitial());
      } else {
        emit(MovieInitial());
        emit(MovieFailure("Failed to add movies"));
      }
    } catch (e) {
      print("isi error insert: $e");
      emit(MovieInitial());
      emit(MovieFailure("Failed to add movies"));
    }
  }
}
