<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<style>

.wrapper {
    background: #ececec;
    color: #555;
    cursor: help;
    position: relative;
    text-align: justify;
    width: max-content;
    -webkit-transform: translateZ(0); /* webkit flicker fix */
    transform: translateZ(0);
    -webkit-font-smoothing: antialiased; /* webkit text rendering fix */
}
    
.wrapper .tooltip {
    background: #1496bb;
    color: #fff;
    display: block;
    bottom: 60%;
    left: -200px;
    width: 400px;
    margin-bottom: 15px;
    opacity: 0;
    padding: 10px;
    font-size: 12px;
    pointer-events: none;
    position: absolute;
    -webkit-transform: translateY(10px);
        -moz-transform: translateY(10px);
        -ms-transform: translateY(10px);
            -o-transform: translateY(10px);
            transform: translateY(10px);
    -webkit-transition: all .25s ease-out;
        -moz-transition: all .25s ease-out;
        -ms-transition: all .25s ease-out;
            -o-transition: all .25s ease-out;
            transition: all .25s ease-out;
    -webkit-box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
        -moz-box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
        -ms-box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
            -o-box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
            box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.28);
}
    
/* This bridges the gap so you can mouse into the tooltip without it disappearing */
.wrapper .tooltip:before {
    bottom: -20px;
    content: " ";
    display: block;
    height: 20px;
    left: 0;
    position: absolute;
    width: 100%;
}  
    
.wrapper:hover .tooltip {
    opacity: 1;
    pointer-events: auto;
    -webkit-transform: translateY(0px);
        -moz-transform: translateY(0px);
        -ms-transform: translateY(0px);
            -o-transform: translateY(0px);
            transform: translateY(0px);
}
    
    /* IE can just show/hide with no transition */
.lte8 .wrapper .tooltip {
    display: none;
}
    
.lte8 .wrapper:hover .tooltip {
    display: block;
}

</style>

<body>
<h4>fastANI: High throughput ANI analysis</h4>
Version: 1.32
<br>
Reference: <a href="https://doi.org/10.1038/s41467-018-07641-9" target="_blank">https://doi.org/10.1038/s41467-018-07641-9</a>
<br>
Document: <a href="https://github.com/ParBLiss/FastAN" target="_blank">https://github.com/ParBLiss/FastANI</a>
<br>
<br>
<form action="FastANIListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>


Fragment length: <input name="fragLen" value="3000">
<br>

Kmer size (max 16): <input name="kmer" value="16">
<br>
Minimum fraction of genome that must be shared
<span class="wrapper">[?]
    <div class="tooltip">minimum fraction of genome that must be shared for trusting ANI. If reference and query genome size differ, smaller one among the two is considered. [default : 0.2]</div>
</span>
: <input name="minFraction" value="0.2">
<br>
<br>

*Upload query genomes (.fasta): <input multiple type="file" name="input1">
<br>
<br>

Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="fastani">FastANI</h4>
<p>FastANI is developed for fast alignment-free computation of whole-genome Average Nucleotide Identity (ANI). ANI is defined as mean nucleotide identity of orthologous gene pairs shared between two microbial genomes. FastANI supports pairwise comparison of both complete and draft genome assemblies. Its underlying procedure follows a similar workflow as described by <a href="http://www.ncbi.nlm.nih.gov/pubmed/17220447">Goris et al. 2007</a>. However, it avoids expensive sequence alignments and uses <a href="https://github.com/marbl/MashMap">Mashmap</a> as its MinHash based sequence mapping engine to compute the orthologous mappings and alignment identity estimates. Based on our experiments with complete and draft genomes, its accuracy is on par with <a href="http://enve-omics.ce.gatech.edu/ani/">BLAST-based ANI solver</a> and it achieves two to three orders of magnitude speedup. Therefore, it is useful for pairwise ANI computation of large number of genome pairs. More details about its speed, accuracy and potential applications are described here: &quot;<a href="https://doi.org/10.1038/s41467-018-07641-9">High Throughput ANI Analysis of 90K Prokaryotic Genomes Reveals Clear Species Boundaries</a>&quot;.</p>

<br>
<br>

<h4 id="Abstract">Abstract</h4>
<p>A fundamental question in microbiology is whether there is continuum of genetic diversity among genomes, or clear species boundaries prevail instead. Whole-genome similarity metrics such as Average Nucleotide Identity (ANI) help address this question by facilitating high resolution taxonomic analysis of thousands of genomes from diverse phylogenetic lineages. To scale to available genomes and beyond, we present FastANI, a new method to estimate ANI using alignment-free approximate sequence mapping. FastANI is accurate for both finished and draft genomes, and is up to three orders of magnitude faster compared to alignment-based approaches. We leverage FastANI to compute pairwise ANI values among all prokaryotic genomes available in the NCBI database. Our results reveal clear genetic discontinuity, with 99.8% of the total 8 billion genome pairs analyzed conforming to &gt;95% intra-species and &lt;83% inter-species ANI values. This discontinuity is manifested with or without the most frequently sequenced species, and is robust to historic additions in the genome databases.</p>

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