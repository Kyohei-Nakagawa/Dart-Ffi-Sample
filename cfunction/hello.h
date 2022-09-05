// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdio.h>
#include <stdlib.h>

void __declspec(dllexport) hello_world();
int __declspec(dllexport) sum(int a, int b);
void __declspec(dllexport) print_str(char* str);

struct Coordinate
{
    double latitude;
    double longitude;
};

struct Place
{
    char *name;
    struct Coordinate coordinate;
};

struct Coordinate __declspec(dllexport) create_coordinate(double latitude, double longitude);
struct Place __declspec(dllexport) create_place(char *name, double latitude, double longitude);

void __declspec(dllexport) set_coordinate(struct Coordinate coordinate);
void __declspec(dllexport) set_place(struct Place place);
void __declspec(dllexport) print_global_place();
