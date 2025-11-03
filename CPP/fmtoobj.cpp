#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>
#include <unordered_map>

struct mesh2Head {
    ushort sizeof_mesh2Head;
    byte sizeof_mesh2Vertex;
    byte sizeof_mesh2Face;

    uint vert_cnt;
    uint face_cnt;
}

struct mesh2 {
    mesh2Head header
}

int main(int argc,char** argv){

};