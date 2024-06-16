<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>OrthoANIu: A large-scale evaluation of algorithms to calculate average nucleotide identity</h4>
Version: 1.2
<br>
orthoANI:  <a href="https://doi.org/10.1099/ijsem.0.000760" target="_blank">https://doi.org/10.1099/ijsem.0.000760</a>
<br>
orthoANIu: <a href="https://doi.org/10.1007/s10482-017-0844-4" target="_blank">https://doi.org/10.1007/s10482-017-0844-4</a>
<br>
Document: <a href="https://www.ezbiocloud.net/tools/orthoaniu" target="_blank">https://www.ezbiocloud.net/tools/orthoaniu</a>
<br>
<br>
<form action="OrthoANIuListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
Output format: <input name="format" list="format">
<datalist id="format">
	<option value="list">
	<option value="matrix">
	<option value="json">
</datalist>
<br>
Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>
*Upload query genomes (.fasta): <input multiple type="file" name="input1">
<br>
<br>
Email (optional): <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>
<br>
<br>
<br>

<h4 id="orthoANI">OrthoANI</h4>
<p>Species demarcation in <em>Bacteria</em> and <em>Archaea</em> is mainly based on overall genome relatedness, which serves a framework for modern microbiology. Current practice for obtaining these measures between two strains is shifting from experimentally determined similarity obtained by DNA-DNA hybridization (DDH) to genome-sequence-based similarity. Average nucleotide identity (ANI) is a simple algorithm that mimics DDH. Like DDH, ANI values between two genome sequences may be different from each other when reciprocal calculations are compared. We compared 63 690 pairs of genome sequences and found that the differences in reciprocal ANI values are significantly high, exceeding 1 % in some cases. To resolve this problem of not being symmetrical, a new algorithm, named OrthoANI, was developed to accommodate the concept of orthology for which both genome sequences were fragmented and only orthologous fragment pairs taken into consideration for calculating nucleotide identities. OrthoANI is highly correlated with ANI (using BLASTn) and the former showed approximately 0.1 % higher values than the latter. In conclusion, OrthoANI provides a more robust and faster means of calculating average nucleotide identity for taxonomic purposes. The standalone software tools are freely available at <a href="http://www.ezbiocloud.net/sw/oat">http://www.ezbiocloud.net/sw/oat</a>.</p>

<br>
<br>

<h4 id="orthoANI">OrthoANIu</h4>
<p>Average nucleotide identity (ANI) is a category of computational analysis that can be used to define species boundaries of Archaea and Bacteria. Calculating ANI usually involves the fragmentation of genome sequences, followed by nucleotide sequence search, alignment, and identity calculation. The original algorithm to calculate ANI used the BLAST program as its search engine. An improved ANI algorithm, called OrthoANI, was developed to accommodate the concept of orthology. Here, we compared four algorithms to compute ANI, namely ANIb (ANI algorithm using BLAST), ANIm (ANI using MUMmer), OrthoANIb (OrthoANI using BLAST) and OrthoANIu (OrthoANI using USEARCH) using &gt;100,000 pairs of genomes with various genome sizes. By comparing values to the ANIb that is considered a standard, OrthoANIb and OrthoANIu exhibited good correlation in the whole range of ANI values. ANIm showed poor correlation for ANI of &lt;90%. ANIm and OrthoANIu runs faster than ANIb by an order of magnitude. When genomes that are larger than 7 Mbp were analysed, the run-times of ANIm and OrthoANIu were shorter than that of ANIb by 53- and 22-fold, respectively. In conclusion, ANI calculation can be greatly sped up by the OrthoANIu method without losing accuracy. A web-service that can be used to calculate OrthoANIu between a pair of genome sequences is available at <a href="http://www.ezbiocloud.net/tools/ani">http://www.ezbiocloud.net/tools/ani</a> . For large-scale calculation and integration in bioinformatics pipelines, a standalone JAVA program is available for download at <a href="http://www.ezbiocloud.net/tools/orthoaniu">http://www.ezbiocloud.net/tools/orthoaniu</a> .</p>


</body>

<script type="text/javascript">
    function disabledSubmit() {
        document.getElementById("submitBtn").disabled= true;
        return true;
    }
</script>
</html>