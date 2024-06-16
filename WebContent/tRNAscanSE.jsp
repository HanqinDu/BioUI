<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>tRNAscan-SE: Searching for tRNA genes in genomic sequences</h4>
Version: 2.0.9 (July 2021)
<br>
Reference: <a href="https://link.springer.com/protocol/10.1007%2F978-1-4939-9173-0_1" target="_blank">DOI: 10.1007/978-1-4939-9173-0_1</a>
<br>
Document: <a href="https://github.com/UCSC-LoweLab/tRNAscan-SE" target="_blank">https://github.com/UCSC-LoweLab/tRNAscan-SE</a>
<br>
<br>
<form action="tRNAscanSEListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
*Kingdom: <input name="kingdom" list="kingdom">
<datalist id="kingdom">
	<option value="All">
	<option value="Bacterial">
	<option value="Eukaryotic">
	<option value="Archaeal">
	<option value="Other">
</datalist>
<br>
Search for mitochondrial tRNAs: <input name="mitochondrialRNA" list="mitochondrialRNA">
<datalist id="mitochondrialRNA">
	<option value="no">
	<option value="mammal">
	<option value="vert">
</datalist>
<br>
Show both primary and secondary structure components to covariance model bit scores: <input name="primary" list="primary">
<datalist id="primary">
	<option value="no">
	<option value="yes">
</datalist>
<br>
<br>
*Upload query genomes(.fasta): <input multiple type="file" name="input1">
<br>
<br>
* You may keep the email empty and wait for the result online, in which case please do not close this page.
<br>
<br>
Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="Abstract">Abstract</h4>
<p>Transfer RNAs are the largest, most complex non-coding RNA family, universal to all living organisms. tRNAscan-SE has been the de facto tool for predicting tRNA genes in whole genomes. The newly developed version 2.0 has incorporated advanced methodologies with improved probabilistic search software and a suite of new gene models, enabling better functional classification of predicted genes. </p>

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