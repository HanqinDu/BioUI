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
<h4>QIIME 2: inferring phylogenetic tree using MAFFT and fasttree</h4>
Version: 2022.2
<br>
MAFFT Citation: Katoh, K., & Standley, D. M. (2013). MAFFT multiple sequence alignment software version 7: improvements in performance and usability. Molecular biology and evolution, 30(4), 772-780.
<br>
Mask alignment method Citation: Lane, D. 1. (1991). 16S/23S rRNA sequencing. Nucleic acid techniques in bacterial systematics, 115-175.
<br>
fasttree2 Citation: Price, M. N., Dehal, P. S., & Arkin, A. P. (2010). FastTree 2-approximately maximum-likelihood trees for large alignments. PloS one, 5(3), e9490.
<br>
RAxML Citation: Stamatakis, A. (2014). RAxML version 8: a tool for phylogenetic analysis and post-analysis of large phylogenies. Bioinformatics, 30(9), 1312-1313.

<br>
<br>

<ul>
    <li><a href="qiime_import.jsp">import data</a></li>
    <li><a href="QiimeQueryListener?step=quality_control&amp;taskname=${requestScope.taskname}">quality control</a></li>
    <li><a href="QiimeQueryListener?step=cluster&amp;taskname=${requestScope.taskname}">cluster OTUs</a></li>
    <li><strong>phylogenic analysis</strong></li>
    <li>diversity analyisis</li>
    <li><a href="QiimeQueryListener?step=taxonomy&amp;taskname=${requestScope.taskname}">taxonomy assignment</a></li>
</ul>

<br>

<form action="QiimePhylogenyListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" id="task" value=${requestScope.taskname}>
<br>
<br>

Tree inferring method: <input name="tree_inferring" list="tree_inferring" onchange="expandParams(this)" required>
<datalist id="tree_inferring">
    <option value="fasttree">
    <option value="raxml">
</datalist>

<br>



<div id = "parttreeParams">

<br>

Alignment by partTree method 
<span class="wrapper">[?]
    <div class="tooltip">This flag is required if the number of sequences being aligned are larger than 1000000. Disabled by default</div>
</span>
: <input type="checkbox" name="parttree" value="parttree"> 

<br>

</div>


<div id = "raxmlParams">

<br>

Model of Nucleotide Substitution: <input name="p-substitution-model" list="p-substitution-model">
<datalist id="p-substitution-model">
    <option value="GTRGAMMA">
    <option value="GTRGAMMAI">
    <option value="GTRCAT">
</datalist>

<br>

</div>




<br>

The maximum relative frequency of gap characters
<span class="wrapper">[?]
    <div class="tooltip">The maximum relative frequency of gap characters in a column for the column to be retained. This relative frequency must be a number between 0.0 and 1.0 (inclusive), where 0.0 retains only those columns without gap characters, and 1.0 retains all columns regardless of gap character frequency.</div>
</span>
: <input type="text" name="p-max-gap-frequency" value="1.0">

<br>

The minimum relative frequency of at least one non-gap character
<span class="wrapper">[?]
    <div class="tooltip">The minimum relative frequency of at least one non-gap character in a column for that column to be retained. This relative frequency must be a number between 0.0 and 1.0 (inclusive). For example, if a value of 0.4 is provided, a column will only be retained if it contains at least one character that is present in at least 40% of the sequences.</div>
</span>
: <input type="text" name="p-min-conservation" value="0.4">


<br>
<br>

*Max sampling depth for alpha rarefaction 
<span class="wrapper">[?]
    <div class="tooltip">max-depth should be chosen based on treated_table.qzv</div>
</span>
: <input type="text" name="p-max-depth" value="">

<br>
<br>

*Email: <input type="text" name="email" value="">
<br>
<br>

<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="mafft">MAFFT</h4>
<p>Multiple sequence alignment (MSA) plays an important role in evolutionary analyses of biological sequences. MAFFT is an MSA program, first released in 2002. Because of its high performance, MAFFT is becoming popular in recent years.</p>
<p>All the options of MAFFT assume that the input sequences are all homologous, that is, descended from a common ancestor. Thus, all the letters in the input data are aligned. Genomic rearrangement or domain shuffling is not assumed, and thus the order of the letters in each sequence is always preserved, although the sequences can be reordered according to similarity. Most options in MAFFT assume that almost all the pairs in the input sequences can be aligned, locally or globally. In such a situation, there is a tradeoff between accuracy and speed. For example, the PartTree option is a fast and rough method, whereas L-INS-i and G-INS-i are slower and more accurate. RNA structural alignment methods are generally more accurate and computationally more expensive because they need additional calculations.</p>

<br>
<br>

<h4 id="fasttree2">fastTree2</h4>
<p>Where FastTree 1 used nearest-neighbor interchanges (NNIs) and the minimum-evolution criterion to improve the tree, FastTree 2 adds minimum-evolution subtree-pruning-regrafting (SPRs) and maximum-likelihood NNIs. FastTree 2 uses heuristics to restrict the search for better trees and estimates a rate of evolution for each site (the “CAT” approximation). Nevertheless, for both simulated and genuine alignments, FastTree 2 is slightly more accurate than a standard implementation of maximum-likelihood NNIs (PhyML 3 with default settings). Although FastTree 2 is not quite as accurate as methods that use maximum-likelihood SPRs, most of the splits that disagree are poorly supported, and for large alignments, FastTree 2 is 100–1,000 times faster. FastTree 2 inferred a topology and likelihood-based local support values for 237,882 distinct 16S ribosomal RNAs on a desktop computer in 22 hours and 5.8 gigabytes of memory.</p>


<br>
<br>


<h4 id="raxml">RAxML</h4>
<p>RAxML (Randomized Axelerated Maximum Likelihood) is a popular program for phylogenetic analysis of large datasets under maximum likelihood. Its major strength is a fast maximum likelihood tree search algorithm that returns trees with good likelihood scores. It has been continuously maintained and extended to accommodate the increasingly growing input datasets and to serve the needs of the user community. </p>



<br>
<br>


</body>

<script type="text/javascript">
    function disabledSubmit() {
        document.getElementById("submitBtn").disabled= true;
        return true;
    }

    function expandParams(mode){
        document.getElementById("parttreeParams").style.display = "none";
        document.getElementById("raxmlParams").style.display = "none";

		if(mode.value == "fasttree"){
			document.getElementById("parttreeParams").style.display = "block";
		}else if(mode.value == "raxml"){
            document.getElementById("parttreeParams").style.display = "block";
            document.getElementById("raxmlParams").style.display = "block";
        }
	}

	window.onload= function(){
		document.getElementById("task").readOnly = true;

        document.getElementById("parttreeParams").style.display = "none";
        document.getElementById("raxmlParams").style.display = "none";
	}

</script>
</html>