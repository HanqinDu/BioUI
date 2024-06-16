<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
	
	<h4 id="current-task">Server Status</h4>
	${requestScope.message}
	
	<br>

	<h4 id="announcement">Announcement</h4>
	<p>
		important: Please use <b>qq mail</b> for receiving notification. We noticed many mailboxes reject mail from the server<br>
		important: If you don't know what the parameters do, please keep them <b>empty</b><br>
		new: <b>antismash</b> for secondary metabolite biosynthesis gene clusters prediction is now available
	</p>

	<br>

	<h4 id="sharelink">Share Links <a href="LinkShareQueryListener">+</a></h4>
	<p>
		${requestScope.shareLink}
	</p>
	<br>

	<h4 id="Alignment">Pipeline</h4>
	<p><a href="qiime_import.jsp">Qiime2 workflow: analysis of microbial communities based on marker gene amplicon sequencing</a>
	</p>
	
	<br>

	<h4 id="Alignment">Alignment</h4>
	<p><a href="blastnJzz.jsp">Blastn against JZZ database: a collection of genome data obtained from JZZ</a>
		<br><a href="blastpJzz.jsp">Blastp against JZZ database: a collection of genome data obtained from JZZ</a>
		<br><a href="mafft.jsp">MAFFT: Multiple alignment program for amino acid or nucleotide sequences based on fast Fourier transform</a>
	</p>

	<br>

	<h4 id="annotation">Annotation</h4>
	<p>
		<a href="antismash.jsp">antiSMASH: rapid identification, annotation and analysis of secondary metabolite biosynthesis gene clusters</a>
		<br><a href="barnnap.jsp">Barnnap: Basic Rapid Ribosomal RNA Predictor</a>
		<br><a href="eggnog.jsp">eggNOG-mapper: automated construction and annotation of orthologous groups of genes</a>
		<br><a href="kofamscan.jsp">KofamKOALA: KEGG ortholog assignment based on profile HMM and adaptive score threshold</a>
		<br><a href="prodigal.jsp">Prodigal: Fast, reliable protein-coding gene prediction for prokaryotic genomes</a>
		<br><a href="prokka.jsp">Prokka: rapid prokaryotic genome annotation</a>
		<br><a href="tRNAscanSE.jsp">tRNAscan-SE: Searching for tRNA genes in genomic sequences</a>
	</p>

	<br>

	<h4 id="assemble">Assemble</h4>
	<p>
		<a href="spades.jsp">SPAdes: assembler for both standard isolate and single-cell MDA bacteria assemblies</a>
		<br><a href="megahit.jsp">MEGAHIT: an ultra-fast single-node solution for large and complex metagenomics assembly</a>
	</p>

	<br>

	<h4 id="binning">Metagenomic binning</h4>
	<p>
		<a href="maxbin2.jsp">MaxBin2: an automated binning algorithm to recover genomes from multiple metagenomic datasets</a>
	</p>

	<br>

	<h4 id="relatednessIndices">Overall genome relatedness indices</h4>
	<p>
		<a href="compareM.jsp">CompareM: Calculate AAI between all pairs of genomes</a>
		<br><a href="ezaai.jsp">EzAAI: A Pipeline for High Throughput Calculation of Prokaryotic Average Amino Acid Identity</a>
		<br><a href="fastANI.jsp">fastANI: High throughput ANI analysis</a>
		<br><a href="orthoANIu.jsp">OrthoANIu: A large-scale evaluation of algorithms to calculate average nucleotide identity</a>
		<br><a href="pocp.jsp">POCP Calculator: percentage of conserved proteins</a>
	</p>

	<br>

	<h4 id="quality-control">Quality control</h4>
	<p><a href="checkM.jsp">checkM: assessing the quality of microbial genomes recovered from isolates, single cells, and metagenomes</a>
		<br><a href="quast.jsp">QUAST: quality assessment tool for genome assemblies</a>
	</p>
	
	<br>

	<h4 id="taxonomy">Taxonomy</h4>
	<p>
		<a href="gtdbtk_classify.jsp">GTDB-Tk: a toolkit to classify genomes with the Genome Taxonomy Database</a>
		<br><a href="iqtree.jsp">IQ-TREE 2: New Models and Efficient Methods for Phylogenetic Inference in the Genomic Era</a>
		<br><a href="tANI.jsp">tANI (Total Average Nucleotide Identity) based Phylogenies</a>
		<br><a href="ubcg.jsp">UBCG: Up-to-date bacterial core gene set and pipeline for phylogenomic tree reconstruction</a>		
	</p>

	<br>

	<h4 id="tools">Tools</h4>
	<p><a href="abi2seq.jsp">ABI to merged contigs</a>
		<br><a href="concator.jsp">Concator: concat multiple files into one</a>
		<br><a href="reflector.jsp">Reflector: fill other half of symmetric matrix</a>
		<br><a href="spades_filter.jsp">SPAdes Contigs Filter: filter low quality contigs by coverage and length cutoff</a>
		<br><a href="splitter.jsp">Splitter: split fasta file into multiple sequence files with one sequence</a>
		<br><a href="upgma.jsp">UPGMA/WPGMA: Unweighted/Weighted Pair Group Method With Arithmetic Mean</a>
	</p>
	
	<br>
	<br>
	<br>



</body>

</html>