<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>eggNOG-mapper: automated construction and annotation of orthologous groups of genes</h4>
Version: 2.1.6
<br>
Reference: <a href="https://doi.org/10.1093/nar/gkm796" target="_blank">https://doi.org/10.1093/nar/gkm796</a>
<br>
Document: <a href="https://github.com/eggnogdb/eggnog-mapper/wiki" target="_blank">github.com/eggnogdb/eggnog-mapper/wiki</a>
<br>
<br>
<form action="EggnogMapperListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Cpus (max 56): <input type="text" name="cpu" value="56">
<br>

*Input type: <input name="itype" list="itype">
<datalist id="itype">
	<option value="CDS">
	<option value="proteins">
	<option value="genome">
	<option value="metagenome">
</datalist>
<br>

Mode: <input name="method" list="method" id="search_mode" onchange="checkMode(this)">
<datalist id="method">
	<option value="diamond">
	<option value="mmseqs">
	<option value="hmmer_bacteria">
</datalist>
<br>
<br>

Diamond sensmode: <input name="sensmode" list="sensmode" id="diamond_mode">
<datalist id="sensmode">
	<option value="default">
	<option value="fast">
	<option value="mid-sensitive">
	<option value="sensitive">
	<option value="more-sensitive">
	<option value="very-sensitive">
	<option value="ultra-sensitive">
</datalist>
<br>

Gene predict method: <input name="genepred" list="genepred">
<datalist id="genepred">
	<option value="search">
	<option value="prodigal">
</datalist>
<br>
<br>

Substitution matrix: <input name="matrix" list="matrix" id="diamond_matrix">
<datalist id="matrix">
	<option value="BLOSUM62">
	<option value="BLOSUM90">
	<option value="BLOSUM80">
	<option value="BLOSUM50">
	<option value="BLOSUM45">
	<option value="PAM250">
	<option value="PAM70">
	<option value="PAM30">
</datalist>
<br>

Target_orthologs: <input name="target_orthologs" list="target_orthologs">
<datalist id="target_orthologs">
	<option value="one2one">
	<option value="many2one">
	<option value="one2many">
	<option value="many2many">
	<option value="all">
</datalist>
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

<h4 id="EggNOG">EggNOG-mapper</h4>
<p>EggNOG-mapper is a tool for fast functional annotation of novel sequences. It uses precomputed Orthologous Groups (OGs) and phylogenies from the EggNOG database (<a href="http://eggnog5.embl.de">http://eggnog5.embl.de</a>) to transfer functional information from fine-grained orthologs only.</p>
<p>Common uses of eggNOG-mapper include the annotation of novel genomes, transcriptomes or even metagenomic gene catalogs.</p>
<p>The use of orthology predictions for functional annotation permits a higher precision than traditional homology searches (i.e. BLAST searches), as it avoids transferring annotations from close paralogs (duplicate genes with a higher chance of being involved in functional divergence).</p>

<br>
<br>

<h4 id="Database">EggNOG Database</h4>
<p>The identification of orthologous genes forms the basis for most comparative genomics studies. Existing approaches either lack functional annotation of the identified orthologous groups, hampering the interpretation of subsequent results, or are manually annotated and thus lag behind the rapid sequencing of new genomes. Here we present the eggNOG database (‘evolutionary genealogy of genes: Non-supervised Orthologous Groups’), which contains orthologous groups constructed from Smith–Waterman alignments through identification of reciprocal best matches and triangular linkage clustering. Applying this procedure to 312 bacterial, 26 archaeal and 35 eukaryotic genomes yielded 43 582 course-grained orthologous groups of which 9724 are extended versions of those from the original COG/KOG database. We also constructed more fine-grained groups for selected subsets of organisms, such as the 19 914 mammalian orthologous groups. We automatically annotated our non-supervised orthologous groups with functional descriptions, which were derived by identifying common denominators for the genes based on their individual textual descriptions, annotated functional categories, and predicted protein domains. The orthologous groups in eggNOG contain 1 241 751 genes and provide at least a broad functional description for 77% of them. Users can query the resource for individual genes via a web interface or download the complete set of orthologous groups at <a href="http://eggnog.embl.de/">http://eggnog.embl.de</a> .</p>

<br>
<br>


</body>

<script type="text/javascript">
    function disabledSubmit() {
        document.getElementById("submitBtn").disabled= true;
        return true;
    }

	function checkMode(mode) {
		if(mode.value === "diamond" || mode.value === "") {
			document.getElementById("diamond_mode").disabled = false;
			document.getElementById("diamond_matrix").disabled = false;
		}else{
			document.getElementById("diamond_mode").disabled = true;
			document.getElementById("diamond_matrix").disabled = true;
		}
	}
</script>
</html>