<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>tANI (Total Average Nucleotide Identity) based Phylogenies</h4>
Reference: <a href="https://doi.org/10.1093/sysbio/syab060" target="_blank">Improving Phylogenies Based on Average Nucleotide Identity, Incorporating Saturation Correction and Nonparametric Bootstrap Support</a>
<br>
Document: <a href="https://github.com/sophiagosselin/tANI_Matrix" target="_blank">https://github.com/sophiagosselin/tANI_Matrix</a>
<br>
<br>
<form action="TANIListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
<br>

Identity cutoff value: <input type="text" name="identity_cutoff" value="0.7">
<br>

Coverage cutoff value: <input type="text" name="coverage_cutoff" value="0.7">
<br>

Evalue cutoff: <input type="text" name="evalue" value="0.0001">
<br>

Number of bootstraps for tree building: <input type="text" name="bootstraps" value="100">
<br>
<br>

*Upload query genomes (.fasta): <input multiple type="file" name="input1">
<br>
<br>

* You may keep the email empty and wait for the result online, in which case please do not close this page.
<br>
<br>
Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="ani-and-af-calculation">ANI and AF Calculation</h4>
<p>Our ANI and BLAST methodology differs from in two respects. First, we do not limit our search to open reading frames but rather use the full scaffold/contig set of an organism. Second, we fracture the genomes into 1,020 nucleotide fragments in line with previous iterations of ANI calculation. The fragments from the query genome were each compared to the whole reference genome via BLAST+ (v2.7.1). BLAST results were filtered based on coverage, percent identity, and e-values (1E-4 cutoff), and only the top best hit (of query fragment versus reference genome) was retained per fragment (for more information on thresholds see: Coverage and percent identity cutoffs section). Filtered results were used to calculate the ANI and AF.</p>
<p>ANI is calculated not simply the sum of best-hit identities over the total number of genes, but is instead described by the formula: ANI=sum(ID% * Length of Alignment) / sum(Length of the shorter fragment). Alignment fraction is described as: AF = sum(Length of the shorter fragment) / (Length of the Query Genome). The ID%, Length of the Alignment, and Length of the shorter fragment terms refer to the individual blast hits from genome - genome comparisons.</p>

<br>
<br>

<h4 id="tANI-calculation">tANI Calculation</h4>
<p>tANI (Total Average Nucleotide Identity) is a single distance measure from whole-genome data incorporating both the ANI and AF. The distance was calculated by using the formula: tANI = -ln(AF <em> ANI). The natural log added to this calculation counteracts saturation for low AF </em> ANI values.</p>

<br>
<br>

<h4 id="bootstrap-replicates">Bootstrap Replicates</h4>
<p>After genomes were split into 1020 nucleotide segments, individual 1020 nucleotide segments were chosen randomly with replacement and used to create a new data set of fragments for that genome. This new 1020 fragment data set was then compared against all other genomes using the tANI methodology to create a row on the bootstrapped matrix. This process is then repeated on all genomes to fill out the matrix. This matrix was then used to infer a tree. The process is repeated for the number of bootstraps desired, and then those trees were mapped onto the best tree to provide node support values.</p>

<br>
<br>

<h4 id="phylogenies-from-distances">Phylogenies from Distances</h4>
<p>Tree-building from distance matrices was accomplished using the R packages Ape and Phangorn. The balanced minimum evolution algorithm as implemented in the FastME function of APE was used to generate phylogenies for each distance matrix. Parameters used were: nni = TRUE, spr = TRUE, tbr = TRUE. A “best tree” was calculated from the point estimate values (the initial calculated distance matrix in tANI) and a collection of bootstrap topologies from the resampled matrices. Support values were mapped onto the best tree using the function plotBS in Phangorn. </p>
<p>Split graphs were constructed from the distance matrices using Splitstree4 and were included to provide an assessment on how tree-like or tree compatible our distance matrices are. Graphs were built using a NeighborNet distance transformation, ordinary least squares variance, and a lambda fraction of 1.</p>
<p>To evaluate our bootstraps, tree certainty scores were calculated using the IC/TC score calculation algorithm implemented in RAxML v8. Tree distances were calculated using the R package Ape and the treedist function of Phangorn.</p>

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