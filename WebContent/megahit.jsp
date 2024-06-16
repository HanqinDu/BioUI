<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>MEGAHIT: an ultra-fast single-node solution for large and complex metagenomics assembly</h4>
Version: v1.2.9
<br>
Reference: <a href="https://pubmed.ncbi.nlm.nih.gov/25609793/" target="_blank">https://pubmed.ncbi.nlm.nih.gov/25609793/</a>
<br>
Document: <a href="https://github.com/voutcn/megahit" target="_blank">https://github.com/voutcn/megahit</a>
<br>
<br>
<form action="MegaHitListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>


Kmer-min (max 255): <input name="kmer-min" list="kmer-min">
<datalist id="kmer-min">
	<option value="21">
  <option value="25">
  <option value="33">
	<option value="[odd integer]">
</datalist>
<br>

Kmer-max (max 255): <input name="kmer-max" list="kmer-max">
<datalist id="kmer-max">
	<option value="141">
  <option value="151">
  <option value="177">
	<option value="[odd integer]">
</datalist>
<br>

Kmer-step (max 28): <input name="kmer-step" list="kmer-step">
<datalist id="kmer-step">
	<option value="12">
  <option value="16">
  <option value="24">
	<option value="[even integer]">
</datalist>
<br>
<br>
Customer parameters (e.g. --no-mercy --prune-level 3): <input type="text" name="parameters" value="">
<br>
<br>
Upload forward paired-end reads: <input multiple type="file" name="input-1">
<br>
Upload reverse paired-end reads: <input multiple type="file" name="input-2">
<br>
or
<br>
Upload interlaced forward and reverse paired-end reads: <input multiple type="file" name="input--12">
<br>
or
<br>
Upload single-end reads: <input multiple type="file" name="input-r">
<br>
<br>
*Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="megahit">MEGAHIT</h4>
<p>MEGAHIT is an ultra-fast and memory-efficient NGS assembler. It is optimized for metagenomes, but also works well on generic single genome assembly (small or mammalian size) and single-cell assembly.</p>
<p>MEGAHIT is a NGS de novo assembler for assembling large and complex metagenomics data in a time- and cost-efficient manner. It finished assembling a soil metagenomics dataset with 252 Gbps in 44.1 and 99.6 h on a single computing node with and without a graphics processing unit, respectively. MEGAHIT assembles the data as a whole, i.e. no pre-processing like partitioning and normalization was needed. When compared with previous methods on assembling the soil data, MEGAHIT generated a three-time larger assembly, with longer contig N50 and average contig length; furthermore, 55.8% of the reads were aligned to the assembly, giving a fourfold improvement.</p>

<br>
<br>

<h4 id="parameters">Parameters</h4>
<pre><code class="lang-bash">Optional Arguments:
  Basic assembly options:
    -<span class="ruby">-min-count              &lt;int&gt;          minimum multiplicity <span class="hljs-keyword">for</span> filtering (k_min+<span class="hljs-number">1</span>)-mers [<span class="hljs-number">2</span>]
</span>    -<span class="ruby">-k-list                 &lt;int,int,..&gt;   comma-separated list of kmer size
</span>                                            all must be odd, in the range 15-255, increment &lt;= 28)
                                            [21,29,39,59,79,99,119,141]

  Advanced assembly options:
    -<span class="ruby">-no-mercy                              <span class="hljs-keyword">do</span> <span class="hljs-keyword">not</span> add mercy kmers
</span>    -<span class="ruby">-bubble-level           &lt;int&gt;          intensity of bubble merging (<span class="hljs-number">0</span>-<span class="hljs-number">2</span>), <span class="hljs-number">0</span> to disable [<span class="hljs-number">2</span>]
</span>    -<span class="ruby">-merge-level            &lt;l,s&gt;          merge complex bubbles of length &lt;= l*kmer_size <span class="hljs-keyword">and</span> similarity &gt;= s [<span class="hljs-number">20</span>,<span class="hljs-number">0</span>.<span class="hljs-number">95</span>]
</span>    -<span class="ruby">-prune-level            &lt;int&gt;          strength of low depth pruning (<span class="hljs-number">0</span>-<span class="hljs-number">3</span>) [<span class="hljs-number">2</span>]
</span>    -<span class="ruby">-prune-depth            &lt;int&gt;          remove unitigs with avg kmer depth less than this value [<span class="hljs-number">2</span>]
</span>    -<span class="ruby">-disconnect-ratio       &lt;float&gt;        disconnect unitigs <span class="hljs-keyword">if</span> its depth is less than this ratio times
</span>                                            the total depth of itself and its siblings [0.1]
    -<span class="ruby">-low-local-ratio        &lt;float&gt;        remove unitigs <span class="hljs-keyword">if</span> its depth is less than this ratio times
</span>                                            the average depth of the neighborhoods [0.2]
    -<span class="ruby">-max-tip-len            &lt;int&gt;          remove tips less than this value [<span class="hljs-number">2</span>*k]
</span>    -<span class="ruby">-cleaning-rounds        &lt;int&gt;          number of rounds <span class="hljs-keyword">for</span> graph cleanning [<span class="hljs-number">5</span>]
</span>    -<span class="ruby">-no-local                              disable local assembly
</span>    -<span class="ruby">-kmin-<span class="hljs-number">1</span>pass                            use <span class="hljs-number">1</span>pass mode to build SdBG of k_min
</span>
  Presets parameters:
    -<span class="ruby">-presets                &lt;str&gt;          override a group of parameters; possible <span class="hljs-symbol">values:</span>
</span>                                            meta-sensitive: '--min-count 1 --k-list 21,29,39,49,...,129,141'
                                            meta-large: '--k-min 27 --k-max 127 --k-step 10'
                                            (large &amp; complex metagenomes, like soil)

  Hardware options:
    -<span class="ruby">m/--memory              &lt;float&gt;        max memory <span class="hljs-keyword">in</span> byte to be used <span class="hljs-keyword">in</span> SdBG construction
</span>                                            (if set between 0-1, fraction of the machine's total memory) [0.9]
    -<span class="ruby">-mem-flag               &lt;int&gt;          SdBG builder memory mode. <span class="hljs-number">0</span>: minimum; <span class="hljs-number">1</span>: moderate;
</span>                                            others: use all memory specified by '-m/--memory' [1]
    -<span class="ruby">t/--num-cpu-threads     &lt;int&gt;          number of CPU threads [<span class="hljs-comment"># of logical processors]</span>
</span>    -<span class="ruby">-no-hw-accel                           run MEGAHIT without BMI2 <span class="hljs-keyword">and</span> POPCNT hardware instructions
</span>
  Output options:
    -<span class="ruby">o/--out-dir             &lt;string&gt;       output directory [./megahit_out]
</span>    -<span class="ruby">-out-prefix             &lt;string&gt;       output prefix (the contig file will be OUT_DIR/OUT_PREFIX.contigs.fa)
</span>    -<span class="ruby">-min-contig-len         &lt;int&gt;          minimum length of contigs to output [<span class="hljs-number">200</span>]
</span>    -<span class="ruby">-keep-tmp-files                        keep all temporary files
</span>    -<span class="ruby">-tmp-dir                &lt;string&gt;       set temp directory
</span>
Other Arguments:
    -<span class="ruby">-continue                              continue a MEGAHIT run from its last available check point.
</span>                                            please set the output directory correctly when using this option.
    -<span class="ruby">-test                                  run MEGAHIT on a toy test dataset
</span>    -<span class="ruby">h/--help                               print the usage message
</span>    -<span class="ruby">v/--version                            print version</span>
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