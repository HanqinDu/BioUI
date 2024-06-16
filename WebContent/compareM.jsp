<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>CompareM: Calculate AAI between all pairs of genomes</h4>
Version: v0.1.2 [May 2021]
<br>
Citation: If you find this package useful, please cite this git repository (https://github.com/dparks1134/CompareM) 
<br>
<br>
<form action="CompareMListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

*Sequence type: <input name="itype" list="itype">
<datalist id="itype">
	<option value="genome">
	<option value="protein">
</datalist>
<br>

Cpus (max 56): <input type="text" name="cpus" value="56">
<br>
<br>

Expect evalue: <input name="evalue" value="0.001">
<br>

Percent identity for defining homology: <input name="per_identity" value="30.0">
<br>

Percent alignment length of query sequence for defining homology: <input name="per_aln_len" value="70.0">
<br>
<br>

*Upload query protein sequences: <input multiple type="file" name="input1">
<br>
<br>

Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>
<br>
<h4 id="comparem">CompareM</h4>
<p>CompareM is a software toolkit which supports performing large-scale comparative genomic analyses. It provides statistics across sets of genomes (e.g., amino acid identity) and for individual genomes (e.g., codon usage). Parallelized implementations are provided for computationally intensive tasks in order to allow scalability to thousands of genomes. Common workflows are provided as single methods to support easy adoption by users, and a more granular interface provided to allow experienced users to exploit specific functionality. CompareM is open source and released under the GNU General Public License (Version 3).</p>
<h5 id="unsupported">Unsupported</h5>
<p>Unfortunately, I no longer have time to continue support for CompareM. The <a href="http://enve-omics.ce.gatech.edu/aai/">AAI calculator</a> at the Kostas Lab or the <a href="http://leb.snu.ac.kr/ezaai">EzAAI tool</a> may meet your needs.</p>
<h5 id="note">Note</h5>
<p>There is a known issue with CompareM that can results in no homologs being identified when run on some Linux system. This is related to different implementations of &#39;sort&#39;. Titus Brown has suggest a <a href="https://hackmd.io/L2llRUU_SrWfI4OYN-uozQ?view">solution</a> that addresses this for Mac OS X.</p>


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