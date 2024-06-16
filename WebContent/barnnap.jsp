<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>Barnnap: Basic Rapid Ribosomal RNA Predictor</h4>
Version: 0.9
<br>
Citation: Seemann T, barrnap 0.9 : rapid ribosomal RNA prediction, <a href="https://github.com/tseemann/barrnap" target="_blank">https://github.com/tseemann/barrnap</a>
<br>
<br>
<form action="BarnnapListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
*Kingdom: <input name="kingdom" list="kingdom">
<datalist id="kingdom">
	<option value="Bacteria">
	<option value="Archaea">
	<option value="Eukaryota">
	<option value="Metazoan Mitochondra">
</datalist>
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>

*Upload query genomes(.fasta): <input multiple type="file" name="input1">
<br>
<br>

Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="description">Barrnap</h4>
<p>Barrnap predicts the location of ribosomal RNA genes in genomes. It supports bacteria (5S,23S,16S), archaea (5S,5.8S,23S,16S), metazoan mitochondria (12S,16S) and eukaryotes (5S,5.8S,28S,18S).</p>
<p>It takes FASTA DNA sequence as input, and write GFF3 as output. It uses the new <code>nhmmer</code> tool that comes with HMMER 3.1 for HMM searching in RNA:DNA style. Multithreading is supported and one can expect roughly linear speed-ups with more CPUs.</p>

<br>
<br>

<h4 id="comparison-with-rnammer">Comparison with RNAmmer</h4>
<p>Barrnap is designed to be a substitute for <a href="http://www.cbs.dtu.dk/services/RNAmmer/">RNAmmer</a>. It was motivated by my desire to remove <a href="https://github.com/tseemann/prokka">Prokka&#39;s</a> dependency on RNAmmer which is encumbered by a free-for-academic sign-up license, and by RNAmmer&#39;s dependence on legacy HMMER 2.x which conflicts with HMMER 3.x that most people are using now.</p>
<p>RNAmmer is more sophisticated than Barrnap, and more accurate because it uses HMMER 2.x in glocal alignment mode whereas NHMMER 3.x currently only supports local alignment (Sean Eddy expected glocal to be supported in 2014, but it still isn&#39;t available in 2018).</p>
<p>In practice, Barrnap will find all the typical rRNA genes in a few seconds (in bacteria), but may get the end points out by a few bases and will probably miss wierd rRNAs. The HMM models it uses are derived from Rfam, Silva and RefSeq.</p>

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