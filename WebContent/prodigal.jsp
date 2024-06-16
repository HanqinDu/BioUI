<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>Prodigal: Fast, reliable protein-coding gene prediction for prokaryotic genomes</h4>
Version: 2.6.3 (February, 2016)
<br>
Reference: <a href="https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-11-119" target="_blank">Prodigal: prokaryotic gene recognition and translation initiation site identification</a>
<br>
Document: <a href="https://github.com/hyattpd/Prodigal" target="_blank">github.com/hyattpd/Prodigal</a>
<br>
<br>
<form action="ProdigalListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

*Data type: <input name="procedure" list="datatype">
<datalist id="datatype">
	<option value="single">
	<option value="meta">
</datalist>
<br>
<br>

Upload query genomes(.fasta): <input multiple type="file" name="input1">
<br>
<br>

Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="abstract">Abstract</h4>
<p>The quality of automated gene prediction in microbial organisms has improved steadily over the past decade, but there is still room for improvement. Increasing the number of correct identifications, both of genes and of the translation initiation sites for each gene, and reducing the overall number of false positives, are all desirable goals.</p>
<p>With our years of experience in manually curating genomes for the Joint Genome Institute, we developed a new gene prediction algorithm called Prodigal (PROkaryotic DYnamic programming Gene-finding ALgorithm). With Prodigal, we focused specifically on the three goals of improved gene structure prediction, improved translation initiation site recognition, and reduced false positives. We compared the results of Prodigal to existing gene-finding methods to demonstrate that it met each of these objectives.</p>
<p>We built a fast, lightweight, open source gene prediction program called Prodigal <a href="http://compbio.ornl.gov/prodigal/">http://compbio.ornl.gov/prodigal/</a>. Prodigal achieved good results compared to existing methods, and we believe it will be a valuable asset to automated microbial annotation pipelines.</p>


<br>
<br>

<h4 id="features">Features</h4>
<ul>
<li><strong>Predicts protein-coding genes</strong>: Prodigal provides fast, accurate protein-coding gene predictions in GFF3, Genbank, or Sequin table format.</li>
<li><strong>Handles draft genomes and metagenomes</strong>: Prodigal runs smoothly on finished genomes, draft genomes, and metagenomes.</li>
<li><strong>Runs quickly</strong>: Prodigal analyzes the <em>E. coli K-12</em> genome in 10 seconds on a modern MacBook Pro.</li>
<li><strong>Runs unsupervised</strong>: Prodigal is an unsupervised machine learning algorithm. It does not need to be provided with any training data, and instead automatically learns the properties of the genome from the sequence itself, including RBS motif usage, start codon usage, and coding statistics.</li>
<li><strong>Handles gaps and partial genes</strong>: The user can specify if Prodigal should build genes across runs of N&#39;s as well as how to handle genes at the edges of contigs.</li>
<li><strong>Identifies translation initiation sites</strong>: Prodigal predicts the correct translation initiation site for most genes, and can output information about every potential start site in the genome, including confidence score, RBS motif, and much more.</li>
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