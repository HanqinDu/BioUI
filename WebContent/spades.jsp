<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>SPAdes: assembler for both standard isolate and single-cell MDA bacteria assemblies</h4>
Version: 3.15.3
<br>
Reference: <a href="https://doi.org/10.1089/cmb.2012.0021" target="_blank">https://doi.org/10.1089/cmb.2012.0021</a>
<br>
<br>
<form action="SPAdesListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
	Task name: <input type="text" name="task" value="task">
<br>

cpus (max 56): <input type="text" name="cpu" value="56">
<br>

*Pipeline: <input name="itype" list="itype">
<datalist id="itype">
	<option value="isolate mode">
	<option value="MDA (single-cell) data">
	<option value="metagenomic data">
	<option value="RNA-Seq data">
	<option value="viral RNA-Seq data">
	<option value="biosyntheticSPAdes">
	<option value="coronaSPAdes">
	<option value="plasmid detection">
	<option value="plasmid detection (meta)">
	<option value="virus detection (meta)">
	<option value="IonTorrent data">
</datalist>
<br>

Pipeline options: <input name="pipemode" list="pipemode">
<datalist id="pipemode">
	<option value="both">
	<option value="error-correction">
	<option value="assembler">
</datalist>
<br>

<b>(isolate mode is recommanded for high-coverage isolate and multi-cell data)</b>

<br>
<br>

List of k-mer sizes (must be odd, seperated by space, e.g. "21 33 51"): <input name="kmer" list="kmer">
<datalist id="kmer">
	<option value="auto">
	<option value="[otherwise please give a list of odd numbers]">
</datalist>

<br>
<br>

Careful mode: reduce number of mismatches and short indels (*incompatible with isolate): <input name="careful" list="careful">
<datalist id="careful">
	<option value="no">
	<option value="yes">
</datalist>
<br>

Coverage cutoff value: <input name="covcut" list="covcut">
<datalist id="covcut">
	<option value="off">
	<option value="auto">
	<option value="[otherwise please type a positive float number]">
</datalist>
<br>

PHRED quality offset in the input reads: <input name="phredoff" list="phredoff">
<datalist id="phredoff">
	<option value="auto-detect">
	<option value="33">
	<option value="64">
</datalist>
<br>


<br>
Upload forward paired-end reads (.fastq .gz): <input type="file" name="input-1">
<br>
Upload reverse paired-end reads (.fastq .gz): <input type="file" name="input-2">
<br>
Upload unpaired paired-end reads (.fastq .gz): <input type="file" name="input-s">
<br>
Upload interlaced forward and reverse paired-end reads (.fastq .gz): <input type="file" name="input--12">
<br>
Upload  merged forward and reverse paired-end reads (.fastq .gz): <input type="file" name="input--merged">
<br>
<br>
Upload Sanger reads: <input type="file" name="input--sanger">
<br>
Upload PacBio reads: <input type="file" name="input--pacbio">
<br>
Upload Nanopore reads: <input type="file" name="input--nanopore">
<br>
Upload trusted contigs: <input type="file" name="input--trusted-contigs">
<br>
Upload untrusted contigs: <input type="file" name="input--untrusted-contigs">
<br>
<br>
*Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="abstract">SPAdes</h4>
<p>The lion&#39;s share of bacteria in various environments cannot be cloned in the laboratory and thus cannot be sequenced using existing technologies. A major goal of single-cell genomics is to complement gene-centric metagenomic data with whole-genome assemblies of uncultivated organisms. Assembly of single-cell data is challenging because of highly non-uniform read coverage as well as elevated levels of sequencing errors and chimeric reads. We describe SPAdes, a new assembler for both single-cell and standard (multicell) assembly, and demonstrate that it improves on the recently released E+V−SC assembler (specialized for single-cell data) and on popular assemblers Velvet and SoapDeNovo (for multicell data). SPAdes generates single-cell assemblies, providing information about genomes of uncultivatable bacteria that vastly exceeds what may be obtained via traditional metagenomics studies. SPAdes is available online (<a href="http://bioinf.spbau.ru/spades">http://bioinf.spbau.ru/spades</a>). It is distributed as open source software.</p>

<br>
<br>

<h4 id="metaspades">metaSpades</h4>
<p>reference: <a href="https://dx.doi.org/10.1101%2Fgr.213959.116">10.1101/gr.213959.116</a></p>
<p>While metagenomics has emerged as a technology of choice for analyzing bacterial populations, the assembly of metagenomic data remains challenging, thus stifling biological discoveries. Moreover, recent studies revealed that complex bacterial populations may be composed from dozens of related strains, thus further amplifying the challenge of metagenomic assembly. metaSPAdes addresses various challenges of metagenomic assembly by capitalizing on computational ideas that proved to be useful in assemblies of single cells and highly polymorphic diploid genomes. We benchmark metaSPAdes against other state-of-the-art metagenome assemblers and demonstrate that it results in high-quality assemblies across diverse data sets.</p>

<br>
<br>

<h4 id="biosyntheticspades-reconstructing-biosynthetic-gene-clusters-from-assembly-graphs">BiosyntheticSPAdes: reconstructing biosynthetic gene clusters from assembly graphs</h4>
<p>reference: <a href="https://dx.doi.org/10.1101%2Fgr.243477.118">10.1101/gr.243477.118</a></p>
<p>Predicting biosynthetic gene clusters (BGCs) is critically important for discovery of antibiotics and other natural products. While BGC prediction from complete genomes is a well-studied problem, predicting BGCs in fragmented genomic assemblies remains challenging. The existing BGC prediction tools often assume that each BGC is encoded within a single contig in the genome assembly, a condition that is violated for most sequenced microbial genomes where BGCs are often scattered through several contigs, making it difficult to reconstruct them. The situation is even more severe in shotgun metagenomics, where the contigs are often short, and the existing tools fail to predict a large fraction of long BGCs. While it is difficult to assemble BGCs in a single contig, the structure of the genome assembly graph often provides clues on how to combine multiple contigs into segments encoding long BGCs. We describe biosyntheticSPAdes, a tool for predicting BGCs in assembly graphs and demonstrate that it greatly improves the reconstruction of BGCs from genomic and metagenomics data sets.</p>

<br>
<br>

<h4 id="coronaspades">coronaSPAdes</h4>
<p>reference: <a href="https://doi.org/10.1093/bioinformatics/btab597">10.1093/bioinformatics/btab597</a></p>
<p>Given an increased interest in coronavirus research, we developed a coronavirus assembly mode for SPAdes assembler (a.k.a. coronaSPAdes). It allows to assemble full-length coronaviridae genomes from the transcriptomic and metatranscriptomic data. Algorithmically, coronaSPAdes is a HMM-guided assembler and it is built upon biosyntheticSPAdes idea of using profile HMMs specific for gene/organism to enhance assembly.
Our preliminary results show that coronaSPAdes outperforms all other SPAdes modes and other popular assemblers in full-length coronavirus recovery.</p>

<br>
<br>
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