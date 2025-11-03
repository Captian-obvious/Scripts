#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>
#include <unordered_map>

typedef struct {
    unsigned short sizeof_mesh2Head;
    byte sizeof_mesh2Vertex;
    byte sizeof_mesh2Face;

    unsigned int vert_cnt;
    unsigned int face_cnt;
} mesh2Head;

typedef struct {
    mesh2Head header;
} mesh2;

int main(int argc,char** argv){

};