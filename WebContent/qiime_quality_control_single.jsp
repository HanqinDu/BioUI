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
<h4>QIIME 2: quality control by DADA2</h4>
Version: 2022.2
<br>
Citation: Callahan, B. J., McMurdie, P. J., Rosen, M. J., Han, A. W., Johnson, A. J. A., & Holmes, S. P. (2016). DADA2: High-resolution sample inference from Illumina amplicon data. Nature methods, 13(7), 581-583.
<br>
<br>

<ul>
    <li><a href="qiime_import.jsp">import data</a></li>
    <li><strong>quality control</strong></li>
    <li>phylogenic analysis</li>
    <li>diversity analyisis</li>
    <li>taxonomy assignment</li>
</ul>

<br>

<form action="QiimeQualityControlSingleListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" id="task" value=${requestScope.taskname}>
<br>
<br>



Method: <input name="method" list="method" onchange="expandParams(this)">
<datalist id="method">
	<option value="dada2">
	<option value="deblur">
</datalist>


<div id = "dada2_params">
<br>


Method used to pool samples for denoising 
<span class="wrapper">[?]
    <div class="tooltip">"independent": Samples are denoised indpendently.<br>"pseudo": The pseudo-pooling method is used to approximate pooling of samples. In short, samples are denoised independently once, ASVs detected in at least 2 samples are recorded, and samples are denoised independently a second time, but this time with prior knowledge of the recorded ASVs and thus higher sensitivity to those ASVs.</div>
</span>
: <input name="p-pooling-method" list="p-pooling-method">
<datalist id="p-pooling-method">
	<option value="independent">
    <option value="pseudo">
</datalist>
<br>





Method used for chimeras removing:
<span class="wrapper">[?]
    <div class="tooltip">"none": No chimera removal is performed.<br>"pooled": All reads are pooled prior to chimera detection.<br>"consensus": Chimeras are detected in samples individually, and sequences found chimeric in a sufficient fraction of samples are removed.</div>
</span>
: <input name="p-chimera-method" list="p-chimera-method">
<datalist id="p-chimera-method">
    <option value="consensus">
    <option value="pooled">
	<option value="none">
</datalist>

<br>
<br>

Sequence read trim position (5') (INTEGER)
<span class="wrapper">[?]
    <div class="tooltip">Position at which sequences should be trimmed due to low quality. This trims the 5' end of the of the input sequences, which will be the bases that were sequenced in the first cycles.</div>
</span>
: <input type="text" name="p-trim-left" value="0">
<br>

*Sequence read truncate position (3') (INTEGER) 
<span class="wrapper">[?]
    <div class="tooltip">Position at which sequences should be truncated due to decrease in quality. This truncates the 3' end of the of the input sequences, which will be the bases that were sequenced in the last cycles. Reads that are shorter than this value will be discarded. If 0 is provided, no truncation or length filtering will be performed</div>
</span>
: <input type="text" name="p-trunc-len" value="0">


<br>
<br>


Quality threshold (INTEGER)
<span class="wrapper">[?]
    <div class="tooltip">Reads are truncated at the first instance of a quality score less than or equal to this value. If the resulting read is then shorter than `trunc-len-f` or `trunc-len-r` (depending on the direction of the read) it is discarded.</div>
</span>
: <input type="text" name="p-trunc-q" value="">

<br>
<br>


</div>



<div id = "deblur_params">
<br>

*Sequence trim length from the 3' end (INTEGER): <input type="text" name="p-trim-length" value="-1">
<br>

Sequence trim length from the 5' end (INTEGER): <input type="text" name="p-left-trim-len" value="">
<br>
<br>

The mean per nucleotide error (NUMBER): <input type="text" name="p-mean-error" value="">
<br>

Insertion/deletion (indel) probability (NUMBER): <input type="text" name="p-indel-prob" value="">
<br>

Maximum number of insertion/deletions (INTEGER): <input type="text" name="p-indel-max" value="">
<br>
<br>

Minimum reads required to be retained in resulting feature table: <input type="text" name="p-min-reads" value="">
<br>

Minimum abundance in each sample required to be retained in resulting feature table: <input type="text" name="p-min-size" value="">


</div>

<br>
<br>




Customer parameters (e.g. --p-n-reads-learn 100000): <input type="text" name="parameters" value="">
<br>
<br>
<br>

*Email: <input type="text" name="email" value="">
<br>
<br>

<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>



<h4 id="dada2">DADA2</h4>
<p> DADA2 infers sample sequences exactly and resolves differences of as little as 1 nucleotide. In several mock communities, DADA2 identified more real variants and output fewer spurious sequences than other methods.</p>
<p>DADA2 implements a new quality-aware model of Illumina amplicon errors. Sample composition is inferred by dividing amplicon reads into partitions consistent with the error model (Online Methods). DADA2 is reference free and applicable to any genetic locus. The DADA2 R package implements the full amplicon workflow: filtering, dereplication, sample inference, chimera identification, and merging of paired-end reads.</p>

<br>
<br>

<h4 id="extra-parameters">Extra parameters</h4>
<pre><code>  <span class="hljs-comment">--p-max-ee NUMBER    reads with number of expected errors higher</span>
                         than this <span class="hljs-built_in">value</span> will be discarded.     [default: <span class="hljs-number">2.0</span>]
  <span class="hljs-comment">--p-min-fold-parent-over-abundance NUMBER</span>
                         The minimum abundance <span class="hljs-keyword">of</span> potential parents <span class="hljs-keyword">of</span> <span class="hljs-keyword">a</span>
                         sequence being tested <span class="hljs-keyword">as</span> chimeric, expressed <span class="hljs-keyword">as</span> <span class="hljs-keyword">a</span>
                         fold-change versus <span class="hljs-keyword">the</span> abundance <span class="hljs-keyword">of</span> <span class="hljs-keyword">the</span> sequence
                         being tested. Values should be greater than <span class="hljs-keyword">or</span> equal
                         <span class="hljs-built_in">to</span> <span class="hljs-number">1</span> (i.e. parents should be more abundant than <span class="hljs-keyword">the</span>
                         sequence being tested). This parameter has no effect
                         <span class="hljs-keyword">if</span> chimera-method is <span class="hljs-string">"none"</span>.           [default: <span class="hljs-number">1.0</span>]
  <span class="hljs-comment">--p-n-reads-learn INTEGER</span>
                         The <span class="hljs-built_in">number</span> <span class="hljs-keyword">of</span> reads <span class="hljs-built_in">to</span> use when training <span class="hljs-keyword">the</span> error
                         model. Smaller numbers will <span class="hljs-built_in">result</span> <span class="hljs-keyword">in</span> <span class="hljs-keyword">a</span> shorter run
                         <span class="hljs-built_in">time</span> but <span class="hljs-keyword">a</span> less reliable error model.
                                                            [default: <span class="hljs-number">1000000</span>]
  <span class="hljs-comment">--p-hashed-feature-ids / --p-no-hashed-feature-ids</span>
                         If <span class="hljs-literal">true</span>, <span class="hljs-keyword">the</span> feature ids <span class="hljs-keyword">in</span> <span class="hljs-keyword">the</span> resulting table will
                         be presented <span class="hljs-keyword">as</span> hashes <span class="hljs-keyword">of</span> <span class="hljs-keyword">the</span> sequences defining <span class="hljs-keyword">each</span>
                         feature. The hash will always be <span class="hljs-keyword">the</span> same <span class="hljs-keyword">for</span> <span class="hljs-keyword">the</span>
                         same sequence so this allows feature tables <span class="hljs-built_in">to</span> be
                         merged across runs <span class="hljs-keyword">of</span> this method. You should only
                         <span class="hljs-built_in">merge</span> tables <span class="hljs-keyword">if</span> <span class="hljs-keyword">the</span> exact same parameters are used
                         <span class="hljs-keyword">for</span> <span class="hljs-keyword">each</span> run.                         [default: True]
</code></pre>

<br>
<br>


</body>

<script type="text/javascript">
    function disabledSubmit() {
        document.getElementById("submitBtn").disabled= true;
        return true;
    }

    function expandParams(method){
        document.getElementById("dada2_params").style.display = "none";
        document.getElementById("deblur_params").style.display = "none";

		if(method.value == "dada2"){
			document.getElementById("dada2_params").style.display = "block";
		}

        if(method.value == "deblur"){
			document.getElementById("deblur_params").style.display = "block";
		}
	}

	window.onload= function(){
		document.getElementById("task").readOnly = true;
        document.getElementById("dada2_params").style.display = "none";
        document.getElementById("deblur_params").style.display = "none";
	}

</script>
</html>