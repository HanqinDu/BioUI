<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>GTDB-Tk: a toolkit to classify genomes with the Genome Taxonomy Database</h4>
Version:1.7.0
<br>
Reference: <a href="https://pubmed.ncbi.nlm.nih.gov/31730192/" target="_blank">doi:10.1093/bioinformatics/btz848</a>
<br>
Document: <a href="https://ecogenomics.github.io/GTDBTk/" target="_blank">https://ecogenomics.github.io/GTDBTk/</a>
<br>
<br>
<form action="GTDBTKListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
Cpus (max 56): <input type="text" name="cpus" value="56">
<br>
<br>
*Upload query genomes(.fasta): <input multiple type="file" name="input1">
<br>
<br>
*Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>
<br>
<br>

<h4 id="summary">Summary</h4>
<p>The Genome Taxonomy Database Toolkit (GTDB-Tk) provides objective taxonomic assignments for bacterial and archaeal genomes based on the GTDB. GTDB-Tk is computationally efficient and able to classify thousands of draft genomes in parallel. Here we demonstrate the accuracy of the GTDB-Tk taxonomic assignments by evaluating its performance on a phylogenetically diverse set of 10 156 bacterial and archaeal metagenome-assembled genomes.</p>

<br>
<br>

<h4 id="Classify-workflow">Classify workflow</h4>
<p>The classify workflow consists of three steps: <code>identify</code>, <code>align</code>, and <code>classify</code>.</p>
<p>The <code>identify</code> step calls genes using <a href="http://compbio.ornl.gov/prodigal/">Prodigal</a>, and uses HMM models and the <a href="http://hmmer.org/">HMMER</a> package to identify the 120 bacterial and 122 archaeal marker genes used for phylogenetic inference (<a href="https://www.ncbi.nlm.nih.gov/pubmed/30148503">Parks et al., 2018</a>). Multiple sequence alignments (MSA) are obtained by aligning marker genes to their respective HMM model.</p>
<p>The <code>align</code> step concatenates the aligned marker genes and filters the concatenated MSA to approximately 5,000 amino acids.</p>
<p>Finally, the <code>classify</code> step uses <a href="http://matsen.fhcrc.org/pplacer/">pplacer</a> to find the maximum-likelihood placement of each genome in the GTDB-Tk reference tree. GTDB-Tk classifies each genome based on its placement in the reference tree, its relative evolutionary divergence, and/or average nucleotide identity (ANI) to reference genomes.</p>
<p>Results can be impacted by a lack of marker genes or contamination. We have validated GTDB-Tk on genomes estimated to be larger than 50% complete with no more than 10% contamination consistent with community standards for medium or higher quality single-amplified and metagenome-assembled genomes (<a href="https://www.ncbi.nlm.nih.gov/pubmed/28787424">Bowers et al., 2017</a>).</p>

<br>
<br>

<h4 id="citation">Citation</h4>
<p>GTDB-Tk makes use of the following 3rd party dependencies and assumes they are on your system path:</p>
<table>
<thead>
<tr>
<th>Software</th>
<th>Version</th>
<th>Reference</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="http://compbio.ornl.gov/prodigal/">Prodigal</a></td>
<td>&gt;= 2.6.2</td>
<td>Hyatt D, et al. 2010. <a href="https://www.ncbi.nlm.nih.gov/pubmed/20211023">Prodigal: prokaryotic gene recognition and translation initiation site identification</a>. <em>BMC Bioinformatics</em>, 11:119. doi: 10.1186/1471-2105-11-119.</td>
</tr>
<tr>
<td><a href="http://hmmer.org/">HMMER</a></td>
<td>&gt;= 3.1b2</td>
<td>Eddy SR. 2011. <a href="https://www.ncbi.nlm.nih.gov/pubmed/22039361">Accelerated profile HMM searches</a>. <em>PLOS Comp. Biol.</em>, 7:e1002195.</td>
</tr>
<tr>
<td><a href="http://matsen.fhcrc.org/pplacer/">pplacer</a></td>
<td>&gt;= 1.1</td>
<td>Matsen FA, et al. 2010. <a href="https://www.ncbi.nlm.nih.gov/pubmed/21034504">pplacer: linear time maximum-likelihood and Bayesian phylogenetic placement of sequences onto a fixed reference tree</a>. <em>BMC Bioinformatics</em>, 11:538.</td>
</tr>
<tr>
<td><a href="https://github.com/ParBLiSS/FastANI">FastANI</a></td>
<td>&gt;= 1.32</td>
<td>Jain C, et al. 2019. <a href="https://www.nature.com/articles/s41467-018-07641-9">High-throughput ANI Analysis of 90K Prokaryotic Genomes Reveals Clear Species Boundaries</a>. <em>Nat. Communications</em>, doi: 10.1038/s41467-018-07641-9.</td>
</tr>
<tr>
<td><a href="http://www.microbesonline.org/fasttree/">FastTree</a></td>
<td>&gt;= 2.1.9</td>
<td>Price MN, et al. 2010. <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2835736/">FastTree 2 - Approximately Maximum-Likelihood Trees for Large Alignments</a>. <em>PLoS One</em>, 5, e9490.</td>
</tr>
<tr>
<td><a href="https://github.com/marbl/Mash">Mash</a></td>
<td>&gt;= 2.2</td>
<td>Ondov BD, et al. 2016. <a href="https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-0997-x">Mash: fast genome and metagenome distance estimation using MinHash</a>. <em>Genome Biol</em> 17, 132. doi: doi: 10.1186/s13059-016-0997-x.</td>
</tr>
</tbody>
</table>
<p>Please cite these tools if you use GTDB-Tk in your work.</p>

<br>
<br>

</body>

<script type="text/javascript">
    function disabledSubmit() {
        document.getElementById("submitBtn").disabled= "disabled";
        return true;
    }
</script>
</html>