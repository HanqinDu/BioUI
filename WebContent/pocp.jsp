<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>POCP Calculator: percentage of conserved proteins</h4>
Implemented by Hanqin Du
<br>
Reference: <a href="https://journals.asm.org/doi/10.1128/JB.01688-14" target="_blank">A Proposed Genus Boundary for the Prokaryotes Based on Genomic Insights</a>
<br>
<br>
<form action="POCPListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>
* the filename should not longer than 42 characters (exclude filename extension)
<br>

Upload query proteins (.faa): <input multiple type="file" name="input1">
<br>
<br>

Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="POCP">percentage of conserved proteins (POCP)</h4>
<p>The conserved proteins between a pair of genomes were determined by aligning all the protein sequences of one genome (query genome) with all the protein sequences of another genome using the BLASTP program (20). Proteins from the query genome were considered conserved when they had a BLAST match with an E value of less than 1e-5, a sequence identity of more than 40%, and an alignable region of the query protein sequence of more than 50%. For a pair of genomes, each genome was used as the query genome to perform the BLASTP search. The number of conserved proteins in each genome of strains being compared was slightly different because of the existence of duplicate genes (paralogs). The percentage of conserved proteins (POCP) between two genomes was calculated as [(C1+C2)/(T1+T2)] * 100%, where C1 and C2 represent the conserved number of proteins in the two genomes being compared, respectively, and T1 and T2 represent the total number of proteins in the two genomes being compared, respectively. In theory, the POCP value can vary from 0%to 100%, depending on the similarity of the protein contents of two genomes.</p>

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