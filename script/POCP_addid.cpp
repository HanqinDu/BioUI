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
  int count = 0;
  while(getline(file, line)) {

    if(line[0] == '>'){
      count++;
      outfile << line << "_;" << count << endl;
      continue;
    }else{
      outfile << line << endl;
    }
  }

  cout << count << endl;

  outfile.close();
  file.close();
  return 0;
}
