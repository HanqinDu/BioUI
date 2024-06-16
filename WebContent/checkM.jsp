<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>checkM: assessing the quality of microbial genomes recovered from isolates, single cells, and metagenomes</h4>
Version: 1.1.3
<br>
Reference: <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4484387/" target="_blank">doi:10.1101/gr.186072.144</a>
<br>
Document: <a href="https://github.com/Ecogenomics/CheckM/wiki" target="_blank">github.com/Ecogenomics/CheckM/wiki</a>
<br>
<br>
<form action="CheckMListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
*Data type: <input name="datatype" list="datatype">
<datalist id="datatype">
	<option value="genome">
	<option value="protein">
</datalist>
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>

e-value cut off: <input name="e_value" value="0.0000000001">
<br>

AAI threshold used to identify strain heterogeneity: <input name="aai_strain" value="0.9">
<br>

Percent overlap between target and query: <input name="length" value="0.7">
<br>
<br>

*Upload query genomes(.fasta) or protein(.faa): <input multiple type="file" name="input1">
<br>
<br>
*Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="abstract">Abstract</h4>
<p>Large-scale recovery of genomes from isolates, single cells, and metagenomic data has been made possible by advances in computational methods and substantial reductions in sequencing costs. Although this increasing breadth of draft genomes is providing key information regarding the evolutionary and functional diversity of microbial life, it has become impractical to finish all available reference genomes. Making robust biological inferences from draft genomes requires accurate estimates of their completeness and contamination. Current methods for assessing genome quality are ad hoc and generally make use of a limited number of &quot;marker&quot; genes conserved across all bacterial or archaeal genomes. Here we introduce CheckM, an automated method for assessing the quality of a genome using a broader set of marker genes specific to the position of a genome within a reference genome tree and information about the collocation of these genes. We demonstrate the effectiveness of CheckM using synthetic data and a wide range of isolate-, single-cell-, and metagenome-derived genomes. CheckM is shown to provide accurate estimates of genome completeness and contamination and to outperform existing approaches. Using CheckM, we identify a diverse range of errors currently impacting publicly available isolate genomes and demonstrate that genomes obtained from single cells and metagenomic data vary substantially in quality. In order to facilitate the use of draft genomes, we propose an objective measure of genome quality that can be used to select genomes suitable for specific gene- and genome-centric analyses of microbial communities.</p>


<br>
<br>
<h4 id="abstract">Workflow</h4>
<p>The recommended workflow for assessing the completeness and contamination of genome bins is to use lineage-specific marker sets. This workflow consists of 4 mandatory (M) steps and 1 recommended (R) step:</p>
<div class="snippet-clipboard-content position-relative overflow-auto" data-snippet-clipboard-copy-content="(M) &gt; checkm tree &lt;bin folder&gt; &lt;output folder&gt;
(R) &gt; checkm tree_qa &lt;output folder&gt;
(M) &gt; checkm lineage_set &lt;output folder&gt; &lt;marker file&gt;
(M) &gt; checkm analyze &lt;marker file&gt; &lt;bin folder&gt; &lt;output folder&gt;
(M) &gt; checkm qa &lt;marker file&gt; &lt;output folder&gt;
"><pre><code>(M) &gt; checkm tree &lt;bin folder&gt; &lt;output folder&gt;
(R) &gt; checkm tree_qa &lt;output folder&gt;
(M) &gt; checkm lineage_set &lt;output folder&gt; &lt;marker file&gt;
(M) &gt; checkm analyze &lt;marker file&gt; &lt;bin folder&gt; &lt;output folder&gt;
(M) &gt; checkm qa &lt;marker file&gt; &lt;output folder&gt;
</code></pre></div>
<p>The <code>tree</code> command places genome bins into a reference genome tree. All genomes to be analyzed must reside in a single <code>bins</code> directory. CheckM assumes genome bins are in FASTA format with the extension <code>fna</code>, though this can be changed with the <code>-x</code> flag. The <code>tree </code>command can optionally be followed by the <code>tree_qa</code> command which will indicate the number of phylogenetically informative marker genes found in each genome bin along with a taxonomic string indicating its approximate placement in the tree. If desired, genome bins with few phylogenetically marker genes may be removed in order to reduce the computational requirements of the following commands. Alternatively, if only genomes from a particular taxonomic group are of interest these can be moved to a new directory and analyzed separately. The <code>lineage_set</code> command creates a marker file indicating lineage-specific marker sets suitable for evaluating each genome. This marker file is passed to the <code>analyze</code> command in order to identify marker genes and estimate the completeness and contamination of each genome bin. Finally, the <code>qa</code> command can be used to produce different tables summarizing the quality of each genome bin.</p>
<p>For convenience, the 4 mandatory steps can be executed using:</p>
<p><code>&gt; checkm lineage_wf &lt;bin folder&gt; &lt;output folder&gt;</code></p>

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