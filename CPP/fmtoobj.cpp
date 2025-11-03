#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>
#include <unordered_map>

typedef unsigned char byte;

typedef struct {
    unsigned short sizeof_mesh2Head;
    byte sizeof_mesh2Vertex;
    byte sizeof_mesh2Face;

    uint vert_cnt;
    uint face_cnt;
} mesh2Head;

typedef struct {
    mesh2Head header;
} mesh2;

int main(int argc,char** argv){

};