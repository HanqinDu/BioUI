#include <iostream>
#include <fstream>
#include <string>
using namespace std;
int main(int argc, char** argv) {

  ofstream outfile;
  outfile.open(argv[2]);

  ifstream file;
  file.open(argv[1]);

  string line;
  string outline;
  int state;

  outfile << "ID,marker_lineage,genomes,markers,marker_sets,0,1,2,3,4,5+,Completeness,Contamination,GC,GC_std,Genome_size,ambiguous_bases,scaffolds,contigs,Longest_scaffold,Longest_contig,N50_scaffolds,N50_contigs,Mean_scaffold_length,Mean_contig_length,Coding_density,Translation_table,predicted_genes,GCN0,GCN1,GCN2,GCN3,GCN4,GCN5+" << endl;

  while(getline(file, line)) {
    outline = "";
    state = 0;

    for(char& c: line) {
      switch (state) {
        case 0:
          if(c == '\t'){state=1; outline.push_back(',');}
          else{outline.push_back(c);}
          break;
        case 1:
          if(c == ':'){state=2;}
          break;
        case 2:
          if(c == ' '){state=3;}
          break;
        case 3:
          if(c == '['){state=5;}
          else{state=4;
            if(c != '\''){
              outline.push_back(c);
            }
          }
          break;
        case 4:
          if(c == ','){state=1; outline.push_back(','); break;}
          if(c != '\''){outline.push_back(c);}
          break;
        case 5:
          if(c == ']'){state=1; outline.push_back(','); break;}
          if(c != ','){outline.push_back(c);}
          break;
      }
    }

    if(outline.length() > 0){
      outline.pop_back();
    }

    outfile << outline << endl;
  }

  file.close();
  outfile.close();

  return 0;
}
