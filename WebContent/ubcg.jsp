<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>UBCG: Up-to-date bacterial core gene set and pipeline for phylogenomic tree reconstruction</h4>
Version: 3.0
<br>
Reference: <a href="https://pubmed.ncbi.nlm.nih.gov/29492869/" target="_blank">DOI: 10.1007/s12275-018-8014-6</a>
<br>
Document: <a href="https://help.ezbiocloud.net/ubcg-users-manual/" target="_blank">https://help.ezbiocloud.net/ubcg-users-manual/</a>
<br>
<br>
<form action="UBCGListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
Alignment method: <input name="alignment" list="alignment">
<datalist id="alignment">
	<option value="nucleotide">
	<option value="amino_acid">
	<option value="codon_based">
	<option value="codon12">
</datalist>
<br>
Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>
*Upload query genomes(.fasta): <input multiple type="file" name="input1">
<br>
(Note that the file name will be used as label)
<br>
<br>
Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="what-is-the-ubcg-">What is the UBCG?</h4>
<p>UBCG stands for the up-to-date bacterial core gene. It is a method and software tool for inferring phylogenetic relationships using a bacterial core gene set that is defined by up-to-date bacterial genome database.</p>
<p>The most widely employed method for genome-based phylogenetic tree reconstruction is using the core gene set. The core gene set can be defined as</p>
<ul>
<li>Genes that are present in the majority of species, if not all</li>
<li>Genes that are present in a single copy (likely orthologous but not paralogous)</li>
</ul>
<p>The number of core genes varies depending on the scope of a target taxon. If you generate a phylogenetic tree for a species, the core gene set may consist of up to thousands of genes. However, to cover any taxa in the domain <em>Bacteria</em>, the core gene set should be restricted to the highly conserved ones (Bacterial Core Gene [BCG]).</p>
<p>Because the number and taxonomic coverage of complete genome sequences in the public database are not perfect, the number of BCG set varies over time.</p>
<p>Here, we compiled the latest bacterial core gene set, named UBCG, using the largest dataset ever (1,429 complete genome sequences, a single genome per a species, covering 28 phyla). The current UBCG set consists of 92 genes whose details are given <a href="https://help.ezbiocloud.net/ubcg-gene-set/">here</a>.</p>

<br>
<br>

<h4 id="concept-of-the-ubcg-pipeline">Concept of the UBCG pipeline</h4>
<p>We designed the pipeline for users to handle hundreds of genomes, if not thousands. Here, the concept behind our design is briefed to help you understand and maximize the utility of our pipeline.</p>
<ul>
<li>All UBCG sequences extracted from each genome sequence are stored in a single file (<em>.**</em>bcg*<em>*). This file also contains a label with full information about the strain (e.g. </em>Escherichia coli<em> K12 MG1665) and other details (e.g. database accession). Once a </em>bcg* file is generated, it can be used for different analyses. This allows users to change the labels in the phylogenetic trees.</li>
<li>A run is carried out using a set of <em>bcg</em> files of user’s choice. For this, selected <em>bcg</em> files are saved in a single directory, then the UBCG pipeline will align each of the core genes, concatenate them, filter aligned positions, and calculate phylogenetic trees and gene support indices (GSIs).</li>
<li>If a user wants to run the pipeline for another set of bcg files, store the desired <em>bcg</em> files in bcg directory and re-run the pipeline. In other words, the set of <em>bcg</em> files to be analyzed together is controlled by the content of a directory holding <em>bcg</em> files.</li>
</ul>

<br>
<br>

</body>


<script type="text/javascript">
    function disabledSubmit() {
        document.getElementById("submitBtn").disabled= true;
        return true;
    }
</script>
</html>