<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>QIIME 2: Next-generation microbiome bioinformatics platform</h4>
Version: 2022.2
<br>
<br>

<ul>
	<li><strong>import data</strong></li>
	<li>quality control</li>
	<li>cluster OTUs</li>
	<li>phylogenic analysis</li>
	<li>diversity analyisis</li>
	<li>taxonomy assignment</li>
</ul>

<br>

<form action="QiimeImportListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
<br>

*Sequencing type: <input name="type" list="type" size=45>
<datalist id="type">
	<option value="SampleData[PairedEndSequencesWithQuality]">
	<option value="SampleData[SequencesWithQuality]">
</datalist>
<br>

*Sequencing format: <input name="format" list="format" size=40>
<datalist id="format">
	<option value="SingleEndFastqManifestPhred33V2">
	<option value="SingleEndFastqManifestPhred64V2">
	<option value="PairedEndFastqManifestPhred33V2">
    <option value="PairedEndFastqManifestPhred64V2">
</datalist>
<br>
<br>

*Upload sequencing data (can be .gz): <input multiple type="file" name="input">
<br>

*Upload manifest (.tsv): <input type="file" name="manifest">
<br>

*Upload sample-metadata (.tsv): <input type="file" name="metadata">
<br>
<br>

*Email: <input type="text" name="email" value="">
<br>
<br>

<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="manifest">Manifest</h4>
<p>for pair-end sequencing:</p>

<a href="Template/qiime_manifest_example.tsv">qiime_manifest_example.tsv</a>
<br>

<table>
<thead>
<tr>
<th>sample-id</th>
<th>forward-absolute-filepath</th>
<th>reverse-absolute-filepath</th>
</tr>
</thead>
<tbody>
<tr>
<td>sample-1</td>
<td>sample1_R1.fastq.gz</td>
<td>sample1_R2.fastq.gz</td>
</tr>
<tr>
<td>sample-2</td>
<td>sample2_R1.fastq.gz</td>
<td>sample2_R2.fastq.gz</td>
</tr>
<tr>
<td>sample-3</td>
<td>sample3_R1.fastq.gz</td>
<td>sample3_R2.fastq.gz</td>
</tr>
<tr>
<td>sample-4</td>
<td>sample4_R1.fastq.gz</td>
<td>sample4_R2.fastq.gz</td>
</tr>
</tbody>
</table>

<br>
<br>

<p>for single-end sequencing:</p>
<table>
<thead>
<tr>
<th>sample-id</th>
<th>absolute-filepath</th>
</tr>
</thead>
<tbody>
<tr>
<td>sample-1</td>
<td>sample1_R1.fastq</td>
</tr>
<tr>
<td>sample-2</td>
<td>sample2_R1.fastq</td>
</tr>
</tbody>
</table>


<br>
<br>


<h4 id="sample-metadata-examples">sample-metadata examples</h4>
<p>the first column must to be one of the following: <strong>id, sampleid, sample id, sample-id, featureid, feature id, feature-id</strong></p>
<p>sample id here should be consist with the one in manifest</p>
<a href="Template/qiime_metadata_example.tsv">qiime_metadata_example.tsv</a>
<br>
<table>
<thead>
<tr>
<th>sample-id</th>
<th>barcode-sequence</th>
<th>body-site</th>
<th>year</th>
<th>month</th>
<th>day</th>
<th>subject</th>
<th>reported-antibiotic-usage</th>
</tr>
</thead>
<tbody>
<tr>
<td>#q2:types</td>
<td>categorical</td>
<td>categorical</td>
<td>numeric</td>
<td>numeric</td>
<td>numeric</td>
<td>categorical</td>
<td>categorical</td>
</tr>
<tr>
<td>sample-1</td>
<td>AGCTGACTAGTC</td>
<td>gut</td>
<td>2008</td>
<td>10</td>
<td>28</td>
<td>subject-1</td>
<td>Yes</td>
</tr>
<tr>
<td>sample-2</td>
<td>ACACACTATGGC</td>
<td>gut</td>
<td>2009</td>
<td>1</td>
<td>20</td>
<td>subject-1</td>
<td>No</td>
</tr>
<tr>
<td>sample-3</td>
<td>ACTACGTGTGGT</td>
<td>gut</td>
<td>2009</td>
<td>2</td>
<td>17</td>
<td>subject-1</td>
<td>No</td>
</tr>
<tr>
<td>sample-4</td>
<td>AGTGCGATGCGT</td>
<td>gut</td>
<td>2009</td>
<td>3</td>
<td>17</td>
<td>subject-1</td>
<td>No</td>
</tr>
</tbody>
</table>

<br>

<table>
<thead>
<tr>
<th>SampleID</th>
<th>SampleName</th>
<th>Host</th>
</tr>
</thead>
<tbody>
<tr>
<td>#q2:types</td>
<td>categorical</td>
<td>categorical</td>
</tr>
<tr>
<td>sample-1</td>
<td>P1</td>
<td>Pig</td>
</tr>
<tr>
<td>sample-2</td>
<td>P2</td>
<td>Pig</td>
</tr>
<tr>
<td>sample-3</td>
<td>C1</td>
<td>Cow</td>
</tr>
<tr>
<td>sample-4</td>
<td>C2</td>
<td>Cow</td>
</tr>
</tbody>
</table>

<br>
<br>



<h4 id="phred-encodings">Phred Encodings</h4>
<p>There are several different ways to encode phred scores with ascii characters. The two most common are called phred+33 and phred+64. The names are strange until you understand how then encoding works.</p>
<h5 id="phred-33">Phred+33</h5>
<p>To use the phred+33 encoding, take the phred quality score, add 33 to it, then use the ascii character corresponding to the sum. For example, using the phred+33 encoding, a quality score of 30 would be represented with the ascii character with the ascii code of 63 (30 + 33), which is ‘?’.</p>
<h5 id="phred-64">Phred+64</h5>
<p>The phred+64 encoding works the same as the phred+33 encoding, except you add 64 to the phred score to determine the ascii code of the quality character. You will only find phred+64 encoding on older data, which was sequenced several years ago. The tricky part is that there is no indication in the FASTQ file as to which encoding was used, you have to make an educated guess.</p>
<pre><code>Phred  Prob of   Phred+33  Phred+64
score   Error     Ascii     Ascii
 <span class="hljs-number"> 0 </span>   1.00000     !         @
 <span class="hljs-number"> 1 </span>   0.79433     "         A
 <span class="hljs-number"> 2 </span>   0.63096     <span class="hljs-comment">#         B</span>
 <span class="hljs-number"> 3 </span>   0.50119     $         C
 <span class="hljs-number"> 4 </span>   0.39811     %         D
 <span class="hljs-number"> 5 </span>   0.31623     &amp;         E
 <span class="hljs-number"> 6 </span>   0.25119     '         F
 <span class="hljs-number"> 7 </span>   0.19953     (         G
 <span class="hljs-number"> 8 </span>   0.15849     )         H
 <span class="hljs-number"> 9 </span>   0.12589     *         I
<span class="hljs-number"> 10 </span>   0.10000     +         J
<span class="hljs-number"> 11 </span>   0.07943     ,         K
<span class="hljs-number"> 12 </span>   0.06310     -         L
<span class="hljs-number"> 13 </span>   0.05012     .         M
<span class="hljs-number"> 14 </span>   0.03981     /         N
<span class="hljs-number"> 15 </span>   0.03162    <span class="hljs-number"> 0 </span>        O
<span class="hljs-number"> 16 </span>   0.02512    <span class="hljs-number"> 1 </span>        P
<span class="hljs-number"> 17 </span>   0.01995    <span class="hljs-number"> 2 </span>        Q
<span class="hljs-number"> 18 </span>   0.01585    <span class="hljs-number"> 3 </span>        R
<span class="hljs-number"> 19 </span>   0.01259    <span class="hljs-number"> 4 </span>        S
<span class="hljs-number"> 20 </span>   0.01000    <span class="hljs-number"> 5 </span>        T
<span class="hljs-number"> 21 </span>   0.00794    <span class="hljs-number"> 6 </span>        U
<span class="hljs-number"> 22 </span>   0.00631    <span class="hljs-number"> 7 </span>        V
<span class="hljs-number"> 23 </span>   0.00501    <span class="hljs-number"> 8 </span>        W
<span class="hljs-number"> 24 </span>   0.00398    <span class="hljs-number"> 9 </span>        X
<span class="hljs-number"> 25 </span>   0.00316     :         Y
<span class="hljs-number"> 26 </span>   0.00251     ;         Z
<span class="hljs-number"> 27 </span>   0.00200     &lt;         [
<span class="hljs-number"> 28 </span>   0.00158     =         \
<span class="hljs-number"> 29 </span>   0.00126     &gt;         ]
<span class="hljs-number"> 30 </span>   0.00100     ?         ^
<span class="hljs-number"> 31 </span>   0.00079     @         _
<span class="hljs-number"> 32 </span>   0.00063     A         `
<span class="hljs-number"> 33 </span>   0.00050     B         a
<span class="hljs-number"> 34 </span>   0.00040     C         b
<span class="hljs-number"> 35 </span>   0.00032     D         c
<span class="hljs-number"> 36 </span>   0.00025     E         d
<span class="hljs-number"> 37 </span>   0.00020     F         e
<span class="hljs-number"> 38 </span>   0.00016     G         f
<span class="hljs-number"> 39 </span>   0.00013     H         g
<span class="hljs-number"> 40 </span>   0.00010     I         h
<span class="hljs-number"> 41 </span>   0.00008     J         i
</code></pre>



<br>
<br>


<h4 id="citation">Citation</h4>
<p>Citation: Bolyen E, Rideout JR, Dillon MR, Bokulich NA, Abnet CC, Al-Ghalith GA, Alexander H, Alm EJ, Arumugam M, Asnicar F, Bai Y, Bisanz JE, Bittinger K, Brejnrod A, Brislawn CJ, Brown CT, Callahan BJ, Caraballo-Rodríguez AM, Chase J, Cope EK, Da Silva R, Diener C, Dorrestein PC, Douglas GM, Durall DM, Duvallet C, Edwardson CF, Ernst M, Estaki M, Fouquier J, Gauglitz JM, Gibbons SM, Gibson DL, Gonzalez A, Gorlick K, Guo J, Hillmann B, Holmes S, Holste H, Huttenhower C, Huttley GA, Janssen S, Jarmusch AK, Jiang L, Kaehler BD, Kang KB, Keefe CR, Keim P, Kelley ST, Knights D, Koester I, Kosciolek T, Kreps J, Langille MGI, Lee J, Ley R, Liu YX, Loftfield E, Lozupone C, Maher M, Marotz C, Martin BD, McDonald D, McIver LJ, Melnik AV, Metcalf JL, Morgan SC, Morton JT, Naimey AT, Navas-Molina JA, Nothias LF, Orchanian SB, Pearson T, Peoples SL, Petras D, Preuss ML, Pruesse E, Rasmussen LB, Rivers A, Robeson MS, Rosenthal P, Segata N, Shaffer M, Shiffer A, Sinha R, Song SJ, Spear JR, Swafford AD, Thompson LR, Torres PJ, Trinh P, Tripathi A, Turnbaugh PJ, Ul-Hasan S, van der Hooft JJJ, Vargas F, Vázquez-Baeza Y, Vogtmann E, von Hippel M, Walters W, Wan Y, Wang M, Warren J, Weber KC, Williamson CHD, Willis AD, Xu ZZ, Zaneveld JR, Zhang Y, Zhu Q, Knight R, and Caporaso JG. 2019. Reproducible, interactive, scalable and extensible microbiome data science using QIIME 2. Nature Biotechnology 37: 852-857. <a href="https://doi.org/10.1038/s41587-019-0209-9">https://doi.org/10.1038/s41587-019-0209-9</a></p>

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