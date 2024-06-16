<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>KofamKOALA: KEGG ortholog assignment based on profile HMM and adaptive score threshold</h4>
Version: v1.3.0
<br>
Reference: <a href="10.1093/bioinformatics/btz859" target="_blank">10.1093/bioinformatics/btz859</a>
<br>
Citation: <br>
&emsp;Aramaki T., Blanc-Mathieu R., Endo H., Ohkubo K., Kanehisa M., Goto S., Ogata H.<br>
&emsp;KofamKOALA: KEGG ortholog assignment based on profile HMM and adaptive score threshold.<br>
&emsp;Bioinformatics. 2019 Nov 19. pii: btz859. doi: 10.1093/bioinformatics/btz859.
<br>
<br>
<form action="KoFamScanListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>

Output format: <input name="outfmt" list="outfmt">
<datalist id="outfmt">
	<option value="detail">
	<option value="detail-tsv">
  <option value="mapper">
  <option value="mapper-one-line">
</datalist>

<br>
<br>

Largest E-value required of the hits: <input name="evalue" list="evalue">
<datalist id="evalue">
	<option value="default">
	<option value="[please enter a positive real number]">
</datalist>
<br>


Threshold-scale: <input name="threshold" list="threshold"> 
<datalist id="threshold">
	<option value="default">
	<option value="[please enter a positive real number]">
</datalist>
<br>
*The score thresholds will be multiplied by this value

<br>
<br>
Customer parameters (e.g. --create-alignment): <input type="text" name="parameters" value="">
<br>
<br>
<br>
*Upload query protein (.fasta .faa): <input multiple type="file" name="input1">
<br>
<br>
*Email (optional): <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="kofamkoala">KofamKOALA</h4>
<p>KofamKOALA assigns K numbers to the user&#39;s sequence data by HMMER/HMMSEARCH against KOfam (a customized HMM database of KEGG Orthologs (KOs)). K number assignments with scores above the predefined thresholds for individual KOs are more reliable than other proposed assignments. Such high score assignments are highlighted with asterisks &#39;*&#39; in the output. The K number assignments facilitate the interpretation of the annotation results by linking the user&#39;s sequence data to the KEGG pathways and EC numbers.</p>

<br>
<br>

<h4 id="more-parameters">More Parameters</h4>
<pre><code>  <span class="hljs-comment">--[no-]report-unannotated  Sequence name will be shown even if no KOs are assigned</span>
                             Default is <span class="hljs-literal">true</span> when <span class="hljs-built_in">format</span>=mapper <span class="hljs-keyword">or</span> mapper-all,
                             <span class="hljs-literal">false</span> when <span class="hljs-built_in">format</span>=detail
  <span class="hljs-comment">--create-alignment         Create domain annotation files for each sequence</span>
                             They will be located <span class="hljs-keyword">in</span> <span class="hljs-keyword">the</span> tmp <span class="hljs-built_in">directory</span>
                             Incompatible <span class="hljs-keyword">with</span> -r
  -r, <span class="hljs-comment">--reannotate           Skip hmmsearch</span>
                             Incompatible <span class="hljs-keyword">with</span> <span class="hljs-comment">--create-alignment</span>
  <span class="hljs-comment">--keep-tabular             Neither create tabular.txt nor delete K number files</span>
                             By default, all K <span class="hljs-built_in">number</span> <span class="hljs-built_in">files</span> will be combined <span class="hljs-keyword">into</span>
                             <span class="hljs-keyword">a</span> tabular.txt <span class="hljs-keyword">and</span> <span class="hljs-built_in">delete</span> them
  <span class="hljs-comment">--keep-output              Neither create output.txt nor delete K number files</span>
                             By default, all K <span class="hljs-built_in">number</span> <span class="hljs-built_in">files</span> will be combined <span class="hljs-keyword">into</span>
                             <span class="hljs-keyword">a</span> output.txt <span class="hljs-keyword">and</span> <span class="hljs-built_in">delete</span> them
                             Must be <span class="hljs-keyword">with</span> <span class="hljs-comment">--create-alignment</span>
</code></pre>


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