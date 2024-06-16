<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>Prokka: rapid prokaryotic genome annotation</h4>
Version: 1.14.6
<br>
Reference: <a href="http://www.ncbi.nlm.nih.gov/pubmed/24642063" target="_blank">doi:10.1093/bioinformatics/btu153</a>
<br>
Citation: Seemann T, "Prokka: Rapid Prokaryotic Genome Annotation", Bioinformatics, 2014 Jul 15;30(14):2068-9.
<br>
<br>

<form action="ProkkaListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>

Sequencing centre ID: <input type="text" name="centre" value="gene">
<br>

*Annotation mode: <input name="kingdom" list="kingdom">
<datalist id="kingdom">
	<option value="Archaea">
  <option value="Bacteria">
  <option value="Mitochondria">
  <option value="Viruses">
</datalist>
<br>
<br>


<input type="checkbox" onchange="expandParams(this)">
<label>advanced setting</label>
<br>

<div id = "extraParams">	
<br>

e-value cut-off (default '1e-09'): <input name="evalue" list="evalue">
<datalist id="evalue">
	<option value="default">
	<option value="[please enter a positive real number]">
</datalist>
<br>

Minimum coverage (default 80): <input name="coverage" list="coverage">
<datalist id="coverage">
	<option value="default">
	<option value="[please enter a positive real number]">
</datalist>
<br>
<br>

Add 'gene' features for each 'CDS' feature: <input name="addgenes" list="addgenes">
<datalist id="addgenes">
	<option value="OFF">
  <option value="ON">
</datalist>
<br>

Add 'mRNA' features for each 'CDS' feature: <input name="addmrna" list="addmrna">
<datalist id="addmrna">
	<option value="OFF">
  <option value="ON">
</datalist>
<br>

Allow [tr]RNA to overlap CDS: <input name="cdsrnaolap" list="cdsrnaolap">
<datalist id="cdsrnaolap">
	<option value="OFF">
  <option value="ON">
</datalist>
<br>
<br>

Customer parameters (e.g. --species Myxococcales): <input type="text" name="parameters" value="">
<br>

</div>
<br>

*Upload contigs (.fasta): <input multiple type="file" name="input1">
<br>
<br>

Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="introduction">Introduction</h4>
<p>Whole genome annotation is the process of identifying features of interest in a set of genomic DNA sequences, and labelling them with useful information. Prokka is a software tool to annotate bacterial, archaeal and viral genomes quickly and produce standards-compliant output files.</p>
<br>
<br>

<h4 id="parameters">Parameters</h4>
<pre><code>Outputs:
  -<span class="ruby">-prefix [X]       Filename output prefix [auto] (default <span class="hljs-string">''</span>)
</span>  -<span class="ruby">-locustag [X]     Locus tag prefix [auto] (default <span class="hljs-string">''</span>)
</span>  -<span class="ruby">-increment [N]    Locus tag counter increment (default <span class="hljs-string">'1'</span>)
</span>  -<span class="ruby">-gffver [N]       GFF version (default <span class="hljs-string">'3'</span>)
</span>  -<span class="ruby">-compliant        Force Genbank/ENA/DDJB <span class="hljs-symbol">compliance:</span> --addgenes --mincontiglen <span class="hljs-number">200</span> --centre XXX (default OFF)
</span>  -<span class="ruby">-centre [X]       Sequencing centre ID. (default <span class="hljs-string">''</span>)
</span>  -<span class="ruby">-accver [N]       Version to put <span class="hljs-keyword">in</span> Genbank file (default <span class="hljs-string">'1'</span>)
</span>Organism details:
  -<span class="ruby">-genus [X]        Genus name (default <span class="hljs-string">'Genus'</span>)
</span>  -<span class="ruby">-species [X]      Species name (default <span class="hljs-string">'species'</span>)
</span>  -<span class="ruby">-strain [X]       Strain name (default <span class="hljs-string">'strain'</span>)
</span>  -<span class="ruby">-plasmid [X]      Plasmid name <span class="hljs-keyword">or</span> identifier (default <span class="hljs-string">''</span>)
</span>Annotations:
  -<span class="ruby">-gcode [N]        Genetic code / Translation table (set <span class="hljs-keyword">if</span> --kingdom is set) (default <span class="hljs-string">'0'</span>)
</span>  -<span class="ruby">-prodigaltf [X]   Prodigal training file (default <span class="hljs-string">''</span>)
</span>  -<span class="ruby">-gram [X]         <span class="hljs-symbol">Gram:</span> -<span class="hljs-regexp">/neg +/pos</span> (default <span class="hljs-string">''</span>)
</span>  -<span class="ruby">-usegenus         Use genus-specific BLAST databases (needs --genus) (default OFF)
</span>  -<span class="ruby">-proteins [X]     FASTA <span class="hljs-keyword">or</span> GBK file to use as <span class="hljs-number">1</span>st priority (default <span class="hljs-string">''</span>)
</span>  -<span class="ruby">-hmms [X]         Trusted HMM to first annotate from (default <span class="hljs-string">''</span>)
</span>  -<span class="ruby">-metagenome       Improve gene predictions <span class="hljs-keyword">for</span> highly fragmented genomes (default OFF)
</span>  -<span class="ruby">-rawproduct       Do <span class="hljs-keyword">not</span> clean up /product annotation (default OFF)
</span>Computation:
  -<span class="ruby">-fast             Fast mode - only use basic BLASTP databases (default OFF)
</span>  -<span class="ruby">-noanno           For CDS just set /product=<span class="hljs-string">"unannotated protein"</span> (default OFF)
</span>  -<span class="ruby">-mincontiglen [N] Minimum contig size [NCBI needs <span class="hljs-number">200</span>] (default <span class="hljs-string">'1'</span>)
</span>  -<span class="ruby">-rfam             Enable searching <span class="hljs-keyword">for</span> ncRNAs with Infernal+Rfam (SLOW!) (default <span class="hljs-string">'0'</span>)
</span>  -<span class="ruby">-norrna           Don<span class="hljs-string">'t run rRNA search (default OFF)
</span></span>  -<span class="ruby"><span class="hljs-string">-notrna           Don'</span>t run tRNA search (default OFF)
</span>  -<span class="ruby">-rnammer          Prefer RNAmmer over Barrnap <span class="hljs-keyword">for</span> rRNA prediction (default OFF)</span>
</code></pre>

<br>
<br>


</body>

<script type="text/javascript">
  function disabledSubmit() {
      document.getElementById("submitBtn").disabled= true;
      return true;
  }

  function expandParams(checkbox){
		if(checkbox.checked == true){
			document.getElementById("extraParams").style.display = "block";
		}else{
			document.getElementById("extraParams").style.display = "none";
		}
	}

	window.onload = function(){
		document.getElementById("extraParams").style.display = "none";
	}

</script>
</html>