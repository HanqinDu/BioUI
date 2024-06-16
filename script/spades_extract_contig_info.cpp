#include <iostream>
#include <fstream>
#include <string>
using namespace std;
int main(int argc, char** argv) {

  ifstream file;
  file.open(argv[1]);

  ofstream outfile;
  outfile.open(argv[2]);

  string line;
  string outline;
  int state;

  outfile << "node,length,coverage" << endl;

  while(getline(file, line)) {
    outline = "";
    state = 0;

    if(line[0] != '>'){
      continue;
    }

    for(char& c: line) {
      switch (state) {
        case 0:
          if(c == '_'){state=1;}
          break;
        case 1:
          if(c == '_'){state=2; outline.push_back(',');}
          else{outline.push_back(c);}
          break;
        case 2:
          if(c == '_'){state=3;}
          break;
        case 3:
          if(c == '_'){state=4; outline.push_back(',');}
          else{outline.push_back(c);}
          break;
        case 4:
          if(c == '_'){state=5;}
          break;
        case 5:
          outline.push_back(c);
          break;
      }
    }
    outfile << outline << endl;
  }

  file.close();
  outfile.close();

  return 0;
}
