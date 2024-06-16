<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>MaxBin2: an automated binning algorithm to recover genomes from multiple metagenomic datasets</h4>
Version: 2.2.7
<br>
Reference: <a href="https://doi.org/10.1093/bioinformatics/btv638" target="_blank">https://doi.org/10.1093/bioinformatics/btv638</a>
<br>
<br>


<form action="MaxbinListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Cpus (max 56): <input type="text" name="threads" value="56">
<br>
<br>

Min contig length: <input type="text" name="min_contig_length" value="1000">
<br>

Max iteration: <input type="text" name="max_iteration" value="50">
<br>

Probability threshold for EM final classification: <input type="text" name="prob_threshold" value="0.9">
<br>

Markerset (defaut 107): <input name="markerset" list="markerset">
<datalist id="markerset">
	<option value="107">
	<option value="40">
</datalist>



<br>
<br>
*Upload contig file (.fasta): <input type="file" name="contig">
<br>
*Upload reads (.fastq .gz): <input multiple type="file" name="reads">
<br>
<br>

*Email: <input type="text" name="email" value="">
<br>
<br>

* it may take about 20 mins to upload 10G of data

<br>

<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="abstract">Abstract</h4>
<p>The recovery of genomes from metagenomic datasets is a critical step to defining the functional roles of the underlying uncultivated populations. We previously developed MaxBin, an automated binning approach for high-throughput recovery of microbial genomes from metagenomes. Here we present an expanded binning algorithm, MaxBin 2.0, which recovers genomes from co-assembly of a collection of metagenomic datasets. Tests on simulated datasets revealed that MaxBin 2.0 is highly accurate in recovering individual genomes, and the application of MaxBin 2.0 to several metagenomes from environmental samples demonstrated that it could achieve two complementary goals: recovering more bacterial genomes compared to binning a single sample as well as comparing the microbial community composition between different sampling environments.</p>


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