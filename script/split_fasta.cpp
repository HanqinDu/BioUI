#include <algorithm>
#include <iostream>
#include <fstream>
#include <string>
using namespace std;


int main(int argc, char** argv) {

  ifstream file;
  file.open(argv[1]);

  ofstream outfile;

  bool is_open = false;
  string line;
  string name;
  string output_folder = argv[2];
  int count = 1;

  while(getline(file, line)) {

    if(line[0] == '\n'){
      continue;
    }

    if(line[0] == '>'){

      name = line.substr(1, line.length());

      if(name.length() == 0){
        name = "unname_" + to_string(count) + ".fasta";
        count++;
      }

      const char a = '/';
      const char b = '\\';
      const char c = '\"';
      const char d = '*';
      const char e = '?';
      const char f = '<';
      const char g = '>';
      const char h = '|';
      const char i = ':';

      const char z = '_';

      replace(name.begin(), name.end(), a, z);
      replace(name.begin(), name.end(), b, z);
      replace(name.begin(), name.end(), c, z);
      replace(name.begin(), name.end(), d, z);
      replace(name.begin(), name.end(), e, z);
      replace(name.begin(), name.end(), f, z);
      replace(name.begin(), name.end(), g, z);
      replace(name.begin(), name.end(), h, z);
      replace(name.begin(), name.end(), i, z);

      if(is_open){outfile.close();}

      outfile.open(output_folder + "/" + name);
      is_open = true;

      outfile << line << endl;
      continue;
    }

    if(is_open){
      outfile << line << endl;
    }

  }

  if(is_open){outfile.close();}
  file.close();

  return 0;
}
