#include <iostream>
#include <fstream>
#include <string>
using namespace std;
int main(int argc, char** argv) {

  ifstream file;
  file.open(argv[1]);

  ofstream outfile;
  outfile.open(argv[2]);

  double cov_cutoff = atof(argv[3]);
  double len_cutoff = atof(argv[4]);

  string line;
  string cov_string;
  string len_string;
  double cov_double;
  double len_double;

  int state;

  bool accept = false;

  while(getline(file, line)) {
    cov_string = "";
    len_string = "";
    state = 0;

    if(line[0] != '>'){
      if(accept){
        outfile << line << endl;
      }
      continue;
    }

    for(char& c: line) {
      switch (state) {
        case 0:
          if(c == '_'){state=1;}
          break;
        case 1:
          if(c == '_'){state=2;}
          break;
        case 2:
          if(c == '_'){state=3;}
          break;
        case 3:
          if(c == '_'){state=4; len_string.push_back(',');}
          else{len_string.push_back(c);}
          break;
        case 4:
          if(c == '_'){state=5;}
          break;
        case 5:
          cov_string.push_back(c);
          break;
      }
    }

    cov_double = stod(cov_string);
    len_double = stod(len_string);

    if(cov_double >= cov_cutoff & len_double >= len_cutoff){
      outfile << line << endl;
      accept = true;
    }else{
      accept = false;
    }

  }

  file.close();
  outfile.close();

  return 0;
}
