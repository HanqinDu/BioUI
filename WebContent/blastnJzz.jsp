<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>Blastn against JZZ database: a collection of genome data obtained from JZZ</h4>
blastn Version: 2.12.0+ 
<br>
JZZ database updated data: 2021.12.28
<br>
Reference: See the end of this page
<br>
<a href="https://www.ncbi.nlm.nih.gov/books/NBK279684/#appendices.Options_for_the_commandline_a" target="_blank">Document</a>

<br>
<br>
<form action="BlastnJZZListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>

Mode: <input name="mode" list="mode">
<datalist id="mode">
	<option value="blastn">
	<option value="blastn-short">
	<option value="megablast">
	<option value="dc-megablast">
</datalist>
<br>

Output format: <input name="outfmt" list="outfmt">
<datalist id="outfmt">
	<option value="CSV">
	<option value="pairwise">
	<option value="tabular">
	<option value="tabular (comment lines)">
	<option value="query-anchored with id">
	<option value="query-anchored">
	<option value="flat query-anchored (id)">
	<option value="flat query-anchored">
	<option value="XML Blast output">
	<option value="Text ASN.1">
	<option value="Binary ASN.1">
	<option value="BLAST archive format">
	<option value="Seqalign (JSON)">
	<option value="Multiple-file BLAST JSON">
	<option value="Multiple-file BLAST XML2">
	<option value="Single-file BLAST JSON">
	<option value="Single-file BLAST XML2">
	<option value="SAM">
	<option value="Organism Report">
</datalist>
<br>
<br>


Expect evalue (e.g. 0.001): <input type="text" name="evalue">
<br>

percent identity cutoff (e.g. 0.7): <input type="text" name="perc_identity">
<br>
<br>


<input type="checkbox" onchange="expandParams(this)">
<label>more parameters</label>

<br>

<div id = "extraParams">	

<br>

Use non-greedy dynamic programming extension: <input name="no_greedy" list="no_greedy">
<datalist id="no_greedy">
	<option value="no">
	<option value="yes">
</datalist>
<br>

Perform ungapped alignment: <input name="ungapped" list="ungapped">
<datalist id="ungapped">
	<option value="no">
	<option value="yes">
</datalist>
<br>
<br>

Length of initial exact match (e.g. 8): <input type="text" name="word_size">
<br>
Gap open cost: <input name="gapopen" list="gapopen">
<datalist id="gapopen">
	<option value="default">
	<option value="[please enter a positive integer]">
</datalist>
<br>

Gap extend cost: <input name="gapextend" list="gapextend">
<datalist id="gapextend">
	<option value="default">
	<option value="[please enter a positive integer]">
</datalist>
<br>

Nucleotide match reward: <input name="reward" list="reward">
<datalist id="reward">
	<option value="default">
	<option value="[please enter a positive integer]">
</datalist>
<br>

Nucleotide mismatch penalty: <input name="penalty" list="penalty">
<datalist id="penalty">
	<option value="default">
	<option value="[please enter a negative integer]">
</datalist>

<br>

</div>


<br>
* the file name should be not longer than 42 characters (exclude filename extension)
<br>

*Upload query sequences(.fasta): <input multiple type="file" name="input1">
<br>
Upload customized database (optional): <input multiple type="file" name="input2">
<br>
<br>
Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="blast">BLAST</h4>
<p>The Basic Local Alignment Search Tool (BLAST) finds regions of local similarity between sequences. The program compares nucleotide or protein sequences to sequence databases and calculates the statistical significance of matches. BLAST can be used to infer functional and evolutionary relationships between sequences as well as help identify members of gene families.</p>

<br>
<br>

<h4 id="-blastn-parameter-https-www-ncbi-nlm-nih-gov-books-nbk279684-appendices-options_for_the_commandline_a-"><a href="https://www.ncbi.nlm.nih.gov/books/NBK279684/#appendices.Options_for_the_commandline_a">Blastn parameter</a></h4>
<h5 id="expect-evalue">expect evalue</h5>
<p>This setting specifies the statistical significance threshold for reporting matches against database sequences. The default value (10) means that 10 such matches are expected to be found merely by chance, according to the stochastic model of Karlin and Altschul (1990). If the statistical significance ascribed to a match is greater than the EXPECT threshold, the match will not be reported. Lower EXPECT thresholds are more stringent, leading to fewer chance matches being reported.</p>
<h5 id="word-size">Word-size</h5>
<p>BLAST is a heuristic that works by finding word-matches between the query and database sequences. One may think of this process as finding &quot;hot-spots&quot; that BLAST can then use to initiate extensions that might eventually lead to full-blown alignments. For nucleotide-nucleotide searches (i.e., &quot;blastn&quot;) an exact match of the entire word is required before an extension is initiated, so that one normally regulates the sensitivity and speed of the search by increasing or decreasing the word-size. For other BLAST searches non-exact word matches are taken into account based upon the similarity between words. The amount of similarity can be varied. </p>
<h5 id="reward-and-penalty-for-nucleotide-programs">Reward and Penalty for Nucleotide Programs</h5>
<p>Many nucleotide searches use a simple scoring system that consists of a &quot;reward&quot; for a match and a &quot;penalty&quot; for a mismatch. The (absolute) reward/penalty ratio should be increased as one looks at more divergent sequences. A ratio of 0.33 (1/-3) is appropriate for sequences that are about 99% conserved; a ratio of 0.5 (1/-2) is best for sequences that are 95% conserved; a ratio of about one (1/-1) is best for sequences that are 75% conserved [1]. Read more <a href="https://www.ncbi.nlm.nih.gov/books/NBK279678">here</a></p>
<p>[1] States DJ, Gish W, and Altschul SF (1991) METHODS: A companion to Methods in Enzymology 3:66-70.</p>

<br>
<br>

<h4 id="Reference">Reference</h4>
<p><a href="https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&amp;PAGE_TYPE=BlastDocs&amp;DOC_TYPE=References">https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&amp;PAGE_TYPE=BlastDocs&amp;DOC_TYPE=References</a></p>
<h5 id="blast-programs">BLAST PROGRAMS</h5>
<p>Altschul, S.F., Gish, W., Miller, W., Myers, E.W. &amp; Lipman, D.J. (1990) &quot;Basic local alignment search tool.&quot; J. Mol. Biol. 215:403-410. <a href="https://www.ncbi.nlm.nih.gov/pubmed/2231712?dopt=Citation">PubMed</a></p>
<p>Gish, W. &amp; States, D.J. (1993) &quot;Identification of protein coding regions by database similarity search.&quot; Nature Genet. 3:266-272. <a href="https://www.ncbi.nlm.nih.gov/pubmed/8790452?dopt=Citation">PubMed</a></p>
<p>Madden, T.L., Tatusov, R.L. &amp; Zhang, J. (1996) &quot;Applications of network BLAST server&quot; Meth. Enzymol. 266:131-141. <a href="https://www.ncbi.nlm.nih.gov/pubmed/8743682?dopt=Citation">PubMed</a></p>
<p>Altschul, S.F., Madden, T.L., Schäffer, A.A., Zhang, J., Zhang, Z., Miller, W. &amp; Lipman, D.J. (1997) &quot;Gapped BLAST and PSI-BLAST: a new generation of protein database search programs.&quot; Nucleic Acids Res. 25:3389-3402. <a href="https://www.ncbi.nlm.nih.gov/pubmed/9254694?dopt=Citation">PubMed</a></p>
<p>Zhang Z., Schwartz S., Wagner L., &amp; Miller W. (2000), &quot;A greedy algorithm for aligning DNA sequences&quot; J Comput Biol 2000; 7(1-2):203-14. <a href="https://www.ncbi.nlm.nih.gov/pubmed/10890397?dopt=Citation">PubMed</a></p>
<p>Zhang, J. &amp; Madden, T.L. (1997) &quot;PowerBLAST: A new network BLAST application for interactive or automated sequence analysis and annotation.&quot; Genome Res. 7:649-656. <a href="https://www.ncbi.nlm.nih.gov/pubmed/9199938?dopt=Citation">PubMed</a></p>
<p>Morgulis A., Coulouris G., Raytselis Y., Madden T.L., Agarwala R., &amp; Schäffer A.A. (2008) &quot;Database indexing for production MegaBLAST searches.&quot; Bioinformatics 15:1757-1764. <a href="https://www.ncbi.nlm.nih.gov/pubmed/18567917?dopt=Citation">PubMed</a></p>
<p>Camacho C., Coulouris G., Avagyan V., Ma N., Papadopoulos J., Bealer K., &amp; Madden T.L. (2008) &quot;BLAST+: architecture and applications.&quot; BMC Bioinformatics 10:421. <a href="https://www.ncbi.nlm.nih.gov/pubmed/20003500?dopt=Citation">PubMed</a></p>
<p>Boratyn GM, Schäffer AA, Agarwala R, Altschul SF, Lipman DJ, &amp; Madden T.L. (2012) &quot;Domain enhanced lookup time accelerated BLAST.&quot; Biol Direct. 2012 Apr 17;7:12. <a href="https://www.ncbi.nlm.nih.gov/pubmed/22510480?dopt=Citation">PubMed</a></p>
<p>Boratyn GM, Thierry-Mieg J, Thierry-Mieg D, Busby B, Madden T.L. (2019) &quot;Magic-BLAST, an accurate RNA-seq aligner for long and short reads.&quot; BMC Bioinformatics. 2019 Jul 25;20(1):405. <a href="https://www.ncbi.nlm.nih.gov/pubmed/31345161">PubMed</a></p>
<h5 id="reviews-improvements-and-useful-introductions">REVIEWS, IMPROVEMENTS AND USEFUL INTRODUCTIONS</h5>
<p>Altschul, S.F., Boguski, M.S., Gish, W. &amp; Wootton, J.C. (1994) &quot;Issues in searching molecular sequence databases.&quot; Nature Genet. 6:119-129. <a href="https://www.ncbi.nlm.nih.gov/pubmed/8162065?dopt=Citation">PubMed</a></p>
<p>McGinnis S., &amp; Madden T.L. (2004) &quot;BLAST: at the core of a powerful and diverse set of sequence analysis tools.&quot; Nucleic Acids Res. 32:W20-W25. <a href="https://www.ncbi.nlm.nih.gov/pubmed/15215342?dopt=Citation">PubMed</a></p>
<p>Ye J., McGinnis S, &amp; Madden T.L. (2006) &quot;BLAST: improvements for better sequence analysis.&quot; Nucleic Acids Res. 34:W6-W9. <a href="https://www.ncbi.nlm.nih.gov/pubmed/16845079">PubMed</a></p>
<p>Johnson M, Zaretskaya I, Raytselis Y, Merezhuk Y, McGinnis S, &amp; Madden T.L. (2008) &quot;NCBI BLAST: a better web interface&quot; Nucleic Acids Res. 36:W5-W9. <a href="https://www.ncbi.nlm.nih.gov/pubmed/18440982">PubMed</a></p>
<p>Boratyn GM, Camacho C, Cooper PS, Coulouris G, Fong A, Ma N, Madden TL, Matten WT, McGinnis SD, Merezhuk Y, Raytselis Y, Sayers EW, Tao T, Ye J, &amp; Zaretskaya I. (2013) &quot;BLAST: a more efficient report with usability improvements.&quot; Nucleic Acids Res. 41:W29-W33. <a href="http://www.ncbi.nlm.nih.gov/pubmed/23609542">PubMed</a></p>
<p>Shiryev SA1, Papadopoulos JS, Schäffer AA, Agarwala R. (2007) &quot;Improved BLAST searches using longer words for protein seeding.&quot; Bioinformatics 23(21):2949-51 <a href="https://www.ncbi.nlm.nih.gov/pubmed/17921491">PubMed</a></p>
<p>Madden, T.L., Busby B., Ye J. (2018) &quot;Reply to the paper: Misunderstood parameters of NCBI BLAST impacts the correctness of bioinformatics workflows.&quot; Bioinformatics. DOI: 10.1093/bioinformatics/bty1026. <a href="https://www.ncbi.nlm.nih.gov/pubmed/30590429">PubMed</a></p>
<h5 id="sequence-filtering">SEQUENCE FILTERING</h5>
<p>Wootton, J.C. &amp; Federhen, S. (1996) &quot;Analysis of compositionally biased regions in sequence databases.&quot; Meth. Enzymol. 266:554-571. <a href="https://www.ncbi.nlm.nih.gov/pubmed/8743706">PubMed</a></p>
<p>Wootton, J.C. &amp; Federhen, S. (1993) &quot;Statistics of local complexity in amino acid sequences and sequence databases.&quot; Comput. Chem. 17:149-163.</p>
<p>Hancock, J.M. &amp; Armstrong, J.S. (1994) &quot;SIMPLE34: an improved and enhanced implementation for VAX and Sun computers of the SIMPLE algorithm for analysis of clustered repetitive motifs in nucleotide sequences.&quot; Comput. Appl. Biosci. 10:67-70. <a href="https://www.ncbi.nlm.nih.gov/pubmed/94251650?dopt=Citation">PubMed</a></p>
<h5 id="alignment-scoring-systems">ALIGNMENT SCORING SYSTEMS</h5>
<p>Dayhoff, M.O., Schwartz, R.M. &amp; Orcutt, B.C. (1978) &quot;A model of evolutionary change in proteins.&quot; In &quot;Atlas of Protein Sequence and Structure, vol. 5, suppl. 3.&quot; M.O. Dayhoff (ed.), pp. 345-352, Natl. Biomed. Res. Found., Washington, DC.</p>
<p>Schwartz, R.M. &amp; Dayhoff, M.O. (1978) &quot;Matrices for detecting distant relationships.&quot; In &quot;Atlas of Protein Sequence and Structure, vol. 5, suppl. 3.&quot; M.O. Dayhoff (ed.), pp. 353-358, Natl. Biomed. Res. Found., Washington, DC.</p>
<p>Altschul, S.F. (1991) &quot;Amino acid substitution matrices from an information theoretic perspective.&quot; J. Mol. Biol. 219:555-565. <a href="https://www.ncbi.nlm.nih.gov/pubmed/2051488?dopt=Citation">PubMed</a></p>
<p>States, D.J., Gish, W., Altschul, S.F. (1991) &quot;Improved sensitivity of nucleic acid database searches using application-specific scoring matrices.&quot; Methods 3:66-70.</p>
<p>Henikoff, S. &amp; Henikoff, J.G. (1992) &quot;Amino acid substitution matrices from protein blocks.&quot; Proc. Natl. Acad. Sci. USA 89:10915-10919. <a href="https://www.ncbi.nlm.nih.gov/pubmed/1438297?dopt=Citation">PubMed</a></p>
<p>Altschul, S.F. (1993) &quot;A protein alignment scoring system sensitive at all evolutionary distances.&quot; J. Mol. Evol. 36:290-300. <a href="https://www.ncbi.nlm.nih.gov/pubmed/8483166?dopt=Citation">PubMed</a></p>
<h5 id="alignment-statistics">ALIGNMENT STATISTICS</h5>
<p>Altschul, S.F. &amp; Gish, W. (1996) &quot;Local alignment statistics.&quot; Meth. Enzymol. 266:460-480. <a href="https://www.ncbi.nlm.nih.gov/pubmed/8743700?dopt=Citation">PubMed</a></p>
<p>Karlin, S. &amp; Altschul, S.F. (1990) &quot;Methods for assessing the statistical significance of molecular sequence features by using general scoring schemes.&quot; Proc. Natl. Acad. Sci. USA 87:2264-2268. <a href="https://www.ncbi.nlm.nih.gov/pubmed/2315319">PubMed</a></p>
<p>Karlin, S. &amp; Altschul, S.F. (1993) &quot;Applications and statistics for multiple high-scoring segments in molecular sequences.&quot; Proc. Natl. Acad. Sci. USA 90:5873-5877. <a href="https://www.ncbi.nlm.nih.gov/pubmed/8390686">PubMed</a></p>
<p>Dembo, A., Karlin, S. &amp; Zeitouni, O. (1994) &quot;Limit distribution of maximal non-aligned two-sequence segmental score.&quot; Ann. Prob. 22:2022-2039.</p>
<p>Altschul, S.F. (1997) &quot;Evaluating the statistical significance of multiple distinct local alignments.&quot; In &quot;Theoretical and Computational Methods in Genome Research.&quot; (S. Suhai, ed.), pp. 1-14, Plenum, New York.</p>
<p>Schaffer AA, Aravind L, Madden TL, Shavirin S, Spouge JL, Wolf YI, Koonin EV, Altschul SF. (2001) &quot;Improving the accuracy of PSI-BLAST protein database searches with composition-based statistics and other refinements.&quot; Nucleic Acids Res. 2001 Jul 15;29(14):2994-3005. <a href="https://www.ncbi.nlm.nih.gov/pubmed/11452024?dopt=Abstract">PubMed</a></p>
<p>Park Y, Sheetlin S, Ma N, Madden TL, &amp; Spouge JL. (2012) &quot;New finite-size correction for local alignment score distributions.&quot; BMC Res Notes. 2012 Jun 12;5:286. <a href="https://www.ncbi.nlm.nih.gov/pubmed/22691307?dopt=Abstract">PubMed</a></p>
<h5 id="programs-that-use-blast">PROGRAMS THAT USE BLAST</h5>
<p>Ye J, Coulouris G, Zaretskaya I, Cutcutache I, Rozen S, &amp; Madden TL. (2012) &quot;Primer-BLAST: a tool to design target-specific primers for polymerase chain reaction.&quot; BMC Bioinformatics 13:134. <a href="https://www.ncbi.nlm.nih.gov/pubmed/22708584?dopt=Citation">PubMed</a></p>
<p>Ye J, Ma N, Madden TL, &amp; Ostell JM. (2013) &quot;IgBLAST: an immunoglobulin variable domain sequence analysis tool.&quot; Nucleic Acids Res. 2013 Jul;41:W34-W40. <a href="https://www.ncbi.nlm.nih.gov/pubmed/23671333">PubMed</a></p>
<p>Papadopoulos JS1 &amp; Agarwala R. (2007) &quot;COBALT: constraint-based alignment tool for multiple protein sequences.&quot; Bioinformatics 23(9):1073-9. <a href="https://www.ncbi.nlm.nih.gov/pubmed/17332019">PubMed</a></p>



<br>
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