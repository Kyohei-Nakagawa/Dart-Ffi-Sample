// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include "hello.h"

struct Coordinate global_coordinate = {0.0, 0.0};
struct Place global_place = {"NULL", {0.0, 0.0}};

int main()
{
    hello_world();
    return 0;
}

// Note:
// ---only on Windows---
// Every function needs to be exported to be able to access the functions by dart.
// Refer: https://stackoverflow.com/q/225432/8608146
void hello_world()
{
    printf("Hello World\n");
}

int sum(int a, int b) {
    return a + b;
}

void print_str(char* str) {
    printf(str);
}

struct Coordinate create_coordinate(double latitude, double longitude)
{
    struct Coordinate coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    return coordinate;
}

struct Place create_place(char *name, double latitude, double longitude)
{
    struct Place place;
    place.name = name;
    place.coordinate = create_coordinate(latitude, longitude);
    return place;
}

void set_coordinate(struct Coordinate coordinate) {
    printf("set latitude: %a \n", coordinate.latitude);
    printf("set longitude: %a \n", coordinate.longitude);
    global_coordinate = coordinate;
}

void set_place(struct Place place) {
    printf("set name: %s \n", place.name);
    global_place = place;
}

void print_global_place() {
    printf("name: %s \n", global_place.name);
    printf("latitude: %a \n", global_place.coordinate.latitude);
    printf("longitude: %a \n", global_place.coordinate.longitude);
}