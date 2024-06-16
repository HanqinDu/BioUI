<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>MAFFT: Multiple alignment program for amino acid or nucleotide sequences based on fast Fourier transform</h4>
Version: V7.490 (2021/Oct/30)
<br>
Reference: See the end of this page
<br>
Document: <a href="https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html" target="_blank">https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html</a>
<br>
<br>
<form action="MafftListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>

*Algorithm: <input name="algorithm" list="algorithm" onchange="checkEnd(this)">
<datalist id="algorithm">
	<option value="Auto">
	<option value="FFT-NS-1">
	<option value="FFT-NS-2">
	<option value="FFT-NS-i">
	<option value="E-INS-i">
	<option value="L-INS-i">
	<option value="G-INS-i">
	<option value="Q-INS-i">
	<option value="X-INS-i">
</datalist>
<br>

Number of iterative refinement: <input name="maxiterate" id = "niter" disabled = "true" value="">
<br>
<br>

*Upload query sequence(.fasta): <input type="file" name="input1">
<br>
<br>
Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>
<br>

<h4 id="about">About</h4>
<p>MAFFT is a multiple sequence alignment program for unix-like operating systems. It offers a range of multiple alignment methods, L-INS-i (accurate; recommended for less than 200 sequences), FFT-NS-2 (fast; recommended for more than 2,000 sequences), <em>etc</em>. </p>

<br>
<br>

<h4 id="merits">Merits</h4>
<ol>
<li><p>(Accuracy) </p>
<p>L-INS-i is one of the most accurate multiple sequence alignment methods currently available. <b>L-INS-i</b> is in particular suitable to align 10-100 protein sequences, because of an objective function combining the WSP and consistency scores. </p>
<p>Protein benchmarks are in:</p>
<ul>
<li><a href="http://www.nature.com/msb/journal/v7/n1/full/msb201175.html">Sievers <em>et al.</em> 2011</a></li>
<li><a href="http://www.blackwell-synergy.com/doi/abs/10.1111/j.1096-0031.2007.00183.x">Simmons <em>et al.</em> 2008</a></li>
<li><a href="http://mbe.oxfordjournals.org/cgi/content/short/24/11/2433">Golubchik <em>et al.</em> 2007</a></li>
<li><a href="http://www.biomedcentral.com/1471-2105/7/484/">Ahola <em>et al.</em> 2006</a></li>
<li><a href="http://www.biomedcentral.com/1471-2105/7/471/">Nuin <em>et al.</em> 2006</a></li>
<li><a href="http://nar.oxfordjournals.org/cgi/content/full/34/16/4364">Pei <em>et al.</em> 2006</a></li>
<li><a href="http://bioinformatics.oxfordjournals.org/cgi/content/short/22/22/2715">Roshan &amp; Liversay 2006</a></li>
<li><a href="http://bioinformatics.oxfordjournals.org/cgi/reprint/22/14/e35">Armougom <em>et al.</em> 2006</a></li>
</ul>
<p>RNA benchmark:</p>
<ul>
<li><a href="http://www.almob.org/content/1/1/19/">Wilm <em>et al.</em> 2006</a></li>
</ul>
<p>DNA benchmark:</p>
<ul>
<li><a href="http://bioinformatics.oxfordjournals.org/cgi/content/abstract/btm389v1">Carroll <em>et al.</em> 2007</a></li>
</ul>
<p>Phylogeny-based benchmark:</p>
<ul>
<li><a href="http://genomebiology.com/2010/11/4/R37">Dessimoz &amp; Gil  2010</a></li>
<li><a href="http://mbe.oxfordjournals.org/cgi/content/abstract/msq140v1">Letsch <em>et al.</em> 2010</a></li>
</ul>
</li>
</ol>
<ol>
<li><p>(Scalability) 
FFT-NS-2 and other progressive methods can align  many and/or long DNA/protein sequences, because of an FFT approximation and a linear-space DP algorithm. </p>
</li>
<li><p>The scoring system was designed to allow large gaps.   Thus MAFFT is suitable for LSU rRNA and SSU rRNA alignments that sometimes have variable loop regions. Staggered gaps (like the figure below) are also allowed. This feature is remarkable with the </p>
<p><strong>--addfragments</strong></p>
<p>option.</p>
<p><img src="https://mafft.cbrc.jp/alignment/software/staggerdgaps.png" alt="staggerd gaps"> </p>
</li>
</ol>

<br>
<br>

<h4 id="limitations">Limitations</h4>
<ol>
<li><p>(Accuracy) 
Library extension is not  performed unlike  <a href="http://igs-server.cnrs-mrs.fr/~cnotred/Projects_home_page/t_coffee_home_page.html">TCoffee</a> and  <a href="http://contra.stanford.edu/contralign/">ProbCons-CONTRAlign</a>, because we think at present that iterative refinement is more efficient than library extension. </p>
</li>
<li><p>(Scalability) 
If two unrelated and long genomic DNA sequences are given, FFT-NS-2 tries to make a full-length alignment using  rigorous DP and requires large CPU time. For such a case, homology search tools such as FASTA and BLAST are more suitable. </p>
</li>
<li><p>The order of alignable blocks or domains are assumed to be conserved for all input sequences. </p>
<p><img src="https://mafft.cbrc.jp/alignment/software/fft.png" alt="limitations"></p>
</li>
</ol>


<br>
<br>

<h4 id="algorithms-and-parameters">Algorithms and parameters</h4>
<p>MAFFT offers various multiple alignment strategies. They are classified into three types, (<strong>a</strong>) the progressive method, (<strong>b</strong>) the iterative refinement method with the WSP score, and (<strong>c</strong>) the iterative refinment method using both the WSP and consistency scores. In general, there is a tradeoff between speed and accuracy. The order of speed is <strong>a</strong> &gt; <strong>b</strong> &gt; <strong>c</strong>, whereas the order of accuracy is <strong>a</strong> &lt; <strong>b</strong> &lt; <strong>c</strong>. The results of benchmarks can be seen <a href="https://mafft.cbrc.jp/alignment/software/eval/accuracy.html">here</a>. The following are the detailed procedures for the major options of MAFFT.</p>
<h4 id="-a-fft-ns-1-fft-ns-2-progressive-methods">(a) FFT-NS-1, FFT-NS-2 — Progressive methods</h4>
<p><img src="https://mafft.cbrc.jp/alignment/software/algorithms/prog.png" alt="prog.png">
These are simple progressive methods like <a href="http://www.ebi.ac.uk/clustalw/">ClustalW</a>. By using the several new techniques described below, these options can align a large number of sequences (up to ∼5,000) on a standard desktop computer. The qualities of the resulting alignments are shown <a href="https://mafft.cbrc.jp/alignment/software/eval/accuracy.html">here</a>. The detailed algorithms are described in Katoh et al. (2002).</p>
<ul>
<li><p>FFT-NS-1</p>
<p><code>mafft --retree 1 *input_file* &gt; *output_file*</code></p>
<p>or</p>
<p><code>fftns --retree 1 *input_file* &gt; *output_file*</code></p>
<p>is the simplest progressive option in MAFFT and one of the fastest methods currently available. The procedure is: (1) make a rough distance matrix by counting the number of shared 6-tuples (see below) between every sequence pair, (2) build a guide tree and (3) align the sequences according to the branching order.</p>
</li>
</ul>
<ul>
<li><strong>FFT-NS-2</strong> 
<strong><code>mafft --retree 2 \*input_file\* &gt; \*output_file\*</code></strong>
or
<strong><code>fftns \*input_file\* &gt; \*output_file\*</code></strong>
The distance matrix used in FFT-NS-1 is very approximate and unreliable. In FFT-NS-2, (4) the guide tree is re-computed from the FFT-NS-1 alignment, and (5) the second progressive alignment is carried out.</li>
</ul>
<p>The following techniques are used to improve the performance.</p>
<p><strong>FFT approximation.</strong> (Not yet written) See Katoh et al. (2002).</p>
<p><strong><em>k\</em>-mer counting.</strong> To accelerate the initial calculation of the distance matrix, which requires a CPU time of <em>O</em>(<em>N</em>2) steps, a rough method similar to the &#39;quicktree&#39; option of ClustalW is adopted, in which the number of <em>k</em>-mers shared by a pair of sequences is counted and regarded as an approximation of the degree of similarity. MAFFT uses the very rapid method proposed by Jones et al. (1992) with a minor modification (Katoh et al. 2002): (1) The 20 amino acids are compressed to 6 alphabets, according to Dayhoff et al. (1978), and (2) MAFFT performs the second progressive alignment (FFT-NS-2) in order to improve the accuracy.</p>
<p><strong>Modified UPGMA.</strong> <a href="https://mafft.cbrc.jp/alignment/software/algorithms/upg.html">A modified version of UPGMA</a> is used to construct a guide tree, which works well for handling fragment sequences.</p>
<p><strong>The second progressive alignment.</strong> The accuracy of the second progressive alignment (FFT-NS-2) is slightly higher than that of the first progressive alignment (FFT-NS-1) according to the <a href="https://mafft.cbrc.jp/alignment/software/eval/accuracy.html">BAliBASE test</a>, but the amount CPU time required by FFT-NS-2 is approximately two times longer than that by FFT-NS-1.</p>
<h4 id="-b-fft-ns-i-nw-ns-i-iterative-refinement-method">(b) FFT-NS-i, NW-NS-i — Iterative refinement method</h4>
<p><img src="https://mafft.cbrc.jp/alignment/software/algorithms/iter.png" alt="iter.png">
The accuracy of progressive alignment can be improved by the iterative refinement method (Berger and Munson 1991, Gotoh 1993). A simplified version of <a href="https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html">PRRN</a> is implemented as the FFT-NS-i option of MAFFT. In FFT-NS-i, an initial alignment by FFT-NS-2 is subjected to an iterative refienment process.</p>
<ul>
<li>FFT-NS-i (max. 1,000 cycles)</li>
</ul>
<p>  <code>mafft --maxiterate 1000 *input_file* &gt; *output_file*</code></p>
<p>  or</p>
<p>  <code>fftnsi --maxiterate 1000 *input_file* &gt; *output_file*</code></p>
<p>  The iterative refinement is repeated until no more improvement in the WSP score is made or the number of cycles reaches 1,000.</p>
<ul>
<li><strong>FFT-NS-i (max. 2 cycles)</strong>
<strong><code>mafft --maxiterate 2 \*input_file\* &gt; \*output_file\*</code></strong>  (Corrected, 2020/Mar/15)
or
<strong><code>fftnsi \*input_file\* &gt; \*output_file\*</code></strong>
As most of the quality of improvement is obtained in the early stage of the iteration, this option is also useful (default of the fftnsi script).</li>
</ul>
<p><strong>Objective function.</strong> The weighted sum-of-pairs (WSP) score proposed by Gotoh is used.</p>
<p><strong>Tree-dependent partitioning.</strong> (Not yet written) See Hirosawa et al.</p>
<p><strong>Effect of FFT.</strong> To test the effect of the FFT approximation, we also implemented the NW-NS-x options, in which the FFT approximation is disabled, but the other procedures are the same as those in the corresponding FFT-NS-x. There was no significant reduction in the accuracy by introducing the FFT approximation (Katoh et al. 2002).</p>
<h4 id="-c-l-ins-i-e-ins-i-g-ins-i-iterative-refinement-methods-using-wsp-and-consistency-scores">(c) L-INS-i, E-INS-i, G-INS-i — Iterative refinement methods using WSP and consistency scores</h4>
<p><img src="https://mafft.cbrc.jp/alignment/software/algorithms/cons.png" alt="cons.png">
In order to obtain more accurate alignments in extremely difficult cases, three new options, L-INS-i, G-INS-i and E-INS-i, have been added to recent versions (v.≥5) of MAFFT. These options use a new objective function combining the WSP score (Gotoh) explained above and the COFFEE-like score (Notredame et al.), which evaluates the consistency between a multiple alignment and pairwise alignments (Katoh et al. 2005).</p>
<p>For pairwise alignment, three different types of algorithms are implemented, global alignment (Needleman-Wunsch), local alignment (Smith-Waterman) with affine gap costs (Gotoh) and local alignment with generalized affine gap costs (Altschul). The differences in the accuracy values among these methods are small for the currently available benchmarks, as shown <a href="https://mafft.cbrc.jp/alignment/software/eval/accuracy.html">here</a>. However, each of them has different characteristics, according to the algorithm in the pairwise alignment stage:</p>
<ul>
<li><p>E-INS-i</p>
<p><code>mafft --genafpair --maxiterate 1000 *input_file* &gt; *output_file*</code></p>
<p>or</p>
<p><code>einsi *input_file* &gt; *output_file*</code></p>
<p>is suitable for alignments like this:</p>
<pre><code><span class="hljs-comment">oooooooooXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXooooooooooo</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">oooooooXXXXXooooooooooooooooo</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">oooooooooooooooo</span>
<span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXoooooooooooooooooooooooooooooooooXXXXX</span><span class="hljs-literal">-</span><span class="hljs-comment">ooooooooooooooooooooooo</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span>
<span class="hljs-comment">oooooooo</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">oooooooooo</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">oooooooooooo</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span>
<span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span>
<span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span>
<span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span>
</code></pre><p>where &#39;</p>
<p>X</p>
<p>&#39;s indicate alignable residues, &#39;</p>
<p>o</p>
<p>&#39;s indicate unalignable residues and &#39;</p>
<p>-</p>
<p>&#39;s indicate gaps. Unalignable residues are left unaligned at the pairwise alignment stage, because of the use of the generalized affine gap cost. Therefore E-INS-i is applicable to a difficult problem such as RNA polymerase, which has several conserved motifs embedded in long unalignable regions. As E-INS-i has the minimum assumption of the three methods, this is recommended if the nature of sequences to be aligned is not clear. Note that E-INS-i assumes that the arrangement of the conserved motifs is shared by all sequences.</p>
<p><strong>Updated!</strong> (2015/Jun) Parameters for E-INS-i have been changed in version 7.243. The new parameters work better for aligning a set of long sequences and short sequences that are closely related to each other. To disable this change, add the <code>**--oldgenafpair**</code> option. </p>
<p>With the new parameters, E-INS-i may be able to align multiple cDNAs and multiple genomic sequences of a gene from closely related species. However, it consumes large memory space when the sequences are long. </p>
</li>
<li><p><strong>L-INS-i</strong>
<strong><code>mafft --localpair --maxiterate 1000 \*input_file\* &gt; \*output_file\*</code></strong>
or
<strong><code>linsi \*input_file\* &gt; \*output_file\*</code></strong>
is suitable to:</p>
<pre><code><span class="hljs-comment">ooooooooooooooooooooooooooooooooXXXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span>
<span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XX</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXXooooooooooo</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span>
<span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">ooooooooooooooXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXooooooooooo</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span>
<span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">ooooooooooooooooooooooooXXXXX</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXoooooooooooooooooo</span>
<span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span>
</code></pre><p>L-INS-i can align a set of sequences containing sequences flanking around one alignable domain. Flanking sequences are ignored in the pairwise alignment by the Smith-Waterman algorithm. Note that the input sequences are assumed to have only one alignable domain. In benchmark tests, the ref4 of BAliBASE corresponds to this. The other categories of BAliBASE also correspond to similar situations, because they have flanking sequences. L-INS-i also shows higher accuracy values for a part of SABmark and HOMSTRAD than G-INS-i, but we have not identified the reason for this.</p>
</li>
<li><p><strong>G-INS-i</strong>
<strong><code>mafft --globalpair --maxiterate 1000 \*input_file\* &gt; \*output_file\*</code></strong>
or
<strong><code>ginsi \*input_file\* &gt; \*output_file\*</code></strong>
is suitable to:</p>
<pre><code><span class="hljs-comment">XXXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXXXXXXXXX</span>
<span class="hljs-comment">XX</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXX</span>
<span class="hljs-comment">XXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXX</span>
<span class="hljs-comment">XXXXX</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXX</span>
<span class="hljs-comment">XXXXXXXXXXXXXXXX</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-literal">-</span><span class="hljs-comment">XXXXXXX</span>
</code></pre><p>G-INS-i assumes that entire region can be aligned and tries to align them globally using the Needleman-Wunsch algorithm; that is, a set of sequences of one domain must be extracted by truncating flanking sequences. In benchmark tests, SABmark and HOMSTRAD correspond to this.</p>
</li>
</ul>
<p><strong>Consistency score.</strong> The COFFEE objective function was originally proposed by Notredame et al. (1998), and the extended versions are used in TCoffee and ProbCons. MAFFT also adopts a similar objective function, as described in Katoh et al. (2005). However, the consistency among three sequences (called &#39;library extension&#39; in TCoffee) is currently not calculated in MAFFT, because the improvement in accuracy by library extension was limited to alignments consisting of a small number (&lt;10) of sequences in our preliminary tests. If library extention is needed, then please use <a href="http://igs-server.cnrs-mrs.fr/~cnotred/Projects_home_page/t_coffee_home_page.html">TCoffee</a> or <a href="http://probcons.stanford.edu/">ProbCons</a>.</p>
<p><strong>Consistency + WSP.</strong> Instead, the WSP score is summed with the consistency score in the objective function of MAFFT. The use of the WSP score has the merit that a pattern of gaps can be incorporated into the objective function. This is probably the reason why MAFFT achieves higher accuracy than ProbCons and TCoffee for alignments consisting of many (∼10 - ∼100) sequences. This suggests that the pattern of gaps within a group to be aligned is important information when aligning two groups of proteins (and evaluating homology between distantly related protein families).</p>
<h4 id="parameters">Parameters</h4>
<p><strong>Scoring matrix for amino acid alignment.</strong> The BLOSUM62 matrix is adopted as a default scoring matrix, because this showed slightly higher accuracy values than the BLOSUM80, 45, JTT200PAM, 100PAM and Gonnet matrices in SABmark tests.</p>
<p><strong>Scoring matrix for nucleotide alignment.</strong> The default scoring matrix is derived from Kimura&#39;s two-parameter model. The ratio of transitions to transversions is set at 2 by default. Other parameters can be used, but have not yet been tested.</p>
<p><strong>Gap penalties for proteins.</strong> The default gap penalties for amino acid alignments have been changed in v.4.0. Note that the current version of MAFFT returns an entirely different alignment from v.&lt;4.0. In v.4.0, two major gap penalties (--op [gap open penalty] and --ep [offset value, which functions like a gap extension penalty, see the <a href="https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html">mafft3 paper</a> for definition]) were tuned by applying the FFT-NS-2 option to a part of the SABmark benchmark. We adopted the parameter set (--op 1.53 --ep 0.123) optimized for SABmark, because this works better for other benchmark (HOMSTRAD, PREFAB and BAliBASE) tests than the previous one (--op 2.4 --ep 0.06). Other parameters might work better in other situations. Consistency-based options have more parameters (L-INS-i has four more parameters and E-INS-i has six more parameters, as explained <a href="https://mafft.cbrc.jp/alignment/software/algorithms/parameters.html">here</a>). We determined these additional parameters so that the Smith-Waterman alignment function used in L-INS-i returns a local alignment similar to that generated by FASTA, but we have not closely tuned them yet. In our tests using SABmark, the accuracy values can be improved by 2-3% by tuning these parameters, but this improvement may result from overfitting.</p>
<p><strong>Gap penalties for RNAs.</strong> The default gap penalties for nucleotide alignment have changed in v.5.6. Note that the current version of MAFFT returns an entirely different alignment from v.&lt;5.6. In the former versions (v.&lt;5.6), the default gap penalties for nucleotide alignments were set at the same values as those for amino acid alignments. According to <a href="http://projects.binf.ku.dk/pgardner/bralibase/">BRAliBASE</a>, these penalties result in very bad alignments for RNAs. The newer versions (v.≥5.6) use a different penalties for nucleotide alignment; the penalty values are set to three times larger than those for amino acids. This is not yet the optimal value for BRAliBASE. The BRAliBASE score can be improved by closely tuning the penalty values, but we have not adopted the optimized penalties, because we are not sure whether they are applicable to a wide range of problems.</p>
<p><strong>Average score or log expectation score.</strong> A different parameter set from from that described above is used in MUSCLE, which has an algorithm similar to that of NW-NS-i. MUSCLE improved in the accuracy of multiple sequence alignment by introducing better parameters than those of the previous version (v3.89) of MAFFT (shown in gray letters <a href="https://mafft.cbrc.jp/alignment/software/eval/accuracy.html">in these tables</a>). The latest version of MAFFT uses the re-adjusted gap penalties (see above) with a conventional average score. As <a href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&amp;db=pubmed&amp;dopt=Abstract&amp;list_uids=15564300&amp;query_hl=3&amp;itool=pubmed_docsum">Wallace <em>et al</em>. (2005)</a> reported that the log expectation score outperforms the conventional average score, we are planning to examine the effectiveness of the log expectation score proposed in MUSCLE.</p>
<h4 id="mafft-homologs">Mafft-homologs</h4>
<p>The accuracy of an alignment of a few distantly related sequences is considerably improved when they are aligned together with their close homologs. The reason for the improvement is probably the same as that for <a href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&amp;db=pubmed&amp;dopt=Abstract&amp;list_uids=9254694&amp;query_hl=6&amp;itool=pubmed_docsum">PSI-BLAST</a>. That is, the positions of highly conserved residues, those with many gaps and other additional information are provided by close homologs. According to <a href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&amp;db=pubmed&amp;dopt=Abstract&amp;list_uids=15661851&amp;query_hl=2&amp;itool=pubmed_docsum">Katoh <em>et al</em>. (2005)</a>, the improvement by adding close homologs is 10% or so, which is comparable to the improvement achieved by incorporating the structural information of a pair of sequences. <a href="http://mafft.cbrc.jp/alignment/server/">Mafft-homologs in the mafft server</a> works like this:</p>
<ol>
<li>Collect a number (50 by default) of close homologs (<em>E</em>=1e-10 by default) of the input sequences.</li>
<li>Align the input sequences and homologs together using the L-INS-i strategy.</li>
<li>Remove the homologs.</li>
</ol>
<p><img src="https://mafft.cbrc.jp/alignment/software/algorithms/mafft-homologs.png" alt="mafft-homologs"></p>
<p>A service based on a similar idea is also available in <a href="http://ibivu.cs.vu.nl/programs/pralinewww/">PRALINE</a>. Note that mafft-homologs aims only to improve the alignment accuracy, but not to comprehensively collect the full-length sequences of homologs. Thus, the resulting alignment with homologs by mafft-homologs is not appropriate for evolutionary analyses. For such a purpose, services with complete sequences, such as <a href="http://bips.u-strasbg.fr/PipeAlign/">PipeAlign</a>, are more appropriate.</p>
<h4 id="mapping-a-nucleotide-base-to-a-complex-number">Mapping a nucleotide base to a complex number</h4>
<p>When the FFT approximation is used in nucleotide alignment, MAFFT v.5.743 and previous versions convert a nucleotide base to a set of four real numbers. For example, the sequence AACGTCT is converted to a set of four arrays: (1,1,0,0,0,0,0), (0,0,1,0,0,1,0), (0,0,0,1,0,0,0) and (0,0,0,0,1,0,1). In v.5.744, this will be replaced with a more efficient method, according to <a href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=retrieve&amp;db=pubmed&amp;list_uids=16522868&amp;dopt=Abstract">Rockwood <em>et al</em>. (2005)</a>. That is, AACGTCT is converted to (<em>i</em>,<em>i</em>,-1,1,-<em>i</em>,1,-<em>i</em>), where <em>i</em> is an imaginary unit.</p>
<h4 id="correction-formula-for-the-6mer-distance">Correction formula for the 6mer distance</h4>
<p>Some options (FFT-NS-2, PartTree, etc.) use the number of 6-tuples shared between every sequence pair as the basis of the guide tree. Mafft3-5 computes the distance <em>Dij</em> between sequences <em>i</em> and <em>j</em> as</p>
<blockquote>
<p><em>Dij</em> = 1 - <em>Sij</em> / min( <em>Sii</em>, <em>Sjj</em> )</p>
</blockquote>
<p>where <em>Sij</em> is the number of shared 6-tuples by sequences <em>i</em> and <em>j</em>. The expected value of <em>Dij</em> between two unrelated sequences depends on the lengths of the sequences; when comparing a very short sequence and a very long sequence, <em>Dij</em> is near 0 by chance, even if the sequences are unrelated to each other. The situation is depicted in the figure below, where the red points indicate <em>Dij</em> calculated for randomly generated aa sequences (by <a href="http://bibiserv.techfak.uni-bielefeld.de/rose/">ROSE</a>) with various pairs of lengths. The cyan surface is</p>
<blockquote>
<p><em>f</em>(<em>x</em>,<em>y</em>) = <em>y</em>/<em>x</em> <em> 0.1 + 10000 / ( </em>x* + 10000 ) + 0.01</p>
</blockquote>
<p>where <em>x</em> and <em>y</em> are the lengths of longer and shorter sequences, respectively. The function <em>f</em>(,) was empirically determined so that the surface is close to the red points. Mafft6 uses <em>Dij&#39;</em> instead of <em>Dij</em>,</p>
<blockquote>
<p><em>Dij</em>&#39; = <em>Dij</em> / <em>f</em>(<em>x</em>,<em>y</em>).</p>
</blockquote>
<p><img src="https://mafft.cbrc.jp/alignment/software/algorithms/lenfac.png" alt="lenfac.png"></p>


<br>
<br>

<h4 id="references">References</h4>
<ul>
<li>Rozewicki, Li, Amada, Standley, Katoh 2019  (<a href="https://mafft.cbrc.jp/alignment/server/jump.html?https://doi.org/10.1093/nar/gkz342"><em>Nucleic Acids Research</em> <strong>47</strong>:W5-W10</a>) <strong>New!</strong> 
 MAFFT-DASH: integrated protein sequence and structural alignment 
 (describes web interface for sequence and structural alignments)</li>
<li>Nakamura, Yamada, Tomii, Katoh 2018  (<a href="https://mafft.cbrc.jp/alignment/server/jump.html?https://doi.org/10.1093/bioinformatics/bty121"><em>Bioinformatics</em> <strong>34</strong>:2490–2492</a>) 
 Parallelization of MAFFT for large-scale multiple sequence alignments. 
 (describes MPI parallelization of accurate progressive options)</li>
<li>Katoh, Rozewicki, Yamada 2019 (<a href="https://mafft.cbrc.jp/alignment/server/jump.html?https://doi.org/10.1093/bib/bbx108"><em>Briefings in Bioinformatics</em> <strong>20</strong>:1160-1166</a>) 
 MAFFT online service: multiple sequence alignment, interactive sequence choice and visualization. 
 (explains online service)</li>
<li>Yamada, Tomii, Katoh 2016 (<a href="https://mafft.cbrc.jp/alignment/server/jump.html?https://doi.org/10.1093/bioinformatics/btw412"><em>Bioinformatics</em> <strong>32</strong>:3246-3251</a>) <a href="https://mafft.cbrc.jp/alignment/server/jump.html?https://mafft.sb.ecei.tohoku.ac.jp/">additional information</a> 
 Application of the MAFFT sequence alignment program to large data—reexamination of the usefulness of chained guide trees. 
 (explains some options for aligning a large number of short sequences)</li>
<li>Katoh, Standley 2016 (<a href="https://mafft.cbrc.jp/alignment/server/jump.html?http://bioinformatics.oxfordjournals.org/content/32/13/1933"><em>Bioinformatics</em> <strong>32</strong>:1933-1942</a>) 
 A simple method to control over-alignment in the MAFFT multiple sequence alignment program. 
 (describes some options to avoid over-alignment)</li>
<li>Katoh, Standley 2013 (<a href="http://mbe.oxfordjournals.org/content/30/4/772"><em>Molecular Biology and Evolution</em> <strong>30</strong>:772-780</a>) 
 MAFFT multiple sequence alignment software version 7: improvements in performance and usability. 
 (outlines version 7)</li>
<li>Kuraku, Zmasek, Nishimura, Katoh  2013 (<a href="http://nar.oxfordjournals.org/content/41/W1/W22.abstract"><em>Nucleic Acids Research</em> <strong>41</strong>:W22-W28</a>) 
 aLeaves facilitates on-demand exploration of metazoan gene family trees on MAFFT sequence alignment server with enhanced interactivity. 
 (describes an interactive sequence collection/selection service by <a href="http://aleaves.cdb.riken.jp/">aLeaves</a>, <a href="https://mafft.cbrc.jp/alignment/server/">MAFFT</a> and <a href="https://mafft.cbrc.jp/alignment/server/gotoaptx.html">Archaeopteryx</a>)</li>
<li>Katoh, Frith 2012 (<a href="http://bioinformatics.oxfordjournals.org/content/28/23/3144"><em>Bioinformatics</em> <strong>28</strong>:3144-3146</a>) 
 Adding unaligned sequences into an existing alignment using MAFFT and LAST. 
 (describes the <a href="https://mafft.cbrc.jp/alignment/software/addsequences.html"><code>**--add**</code></a> and <a href="https://mafft.cbrc.jp/alignment/software/addsequences.html#fragments"><code>**--addfragments**</code></a> options)</li>
<li>Katoh, Toh 2010 (<a href="http://bioinformatics.oxfordjournals.org/cgi/content/abstract/26/15/1899"><em>Bioinformatics</em> <strong>26</strong>:1899-1900</a>) 
 Parallelization of the MAFFT multiple sequence alignment program. 
 (describes the multithread version)</li>
<li>Katoh, Asimenos, Toh 2009 (<a href="http://www.springerlink.com/content/h273273566336n74/"><em>Methods in Molecular Biology</em> <strong>537</strong>:39-64</a>) 
Multiple Alignment of DNA Sequences with MAFFT. In <em>Bioinformatics for DNA Sequence Analysis</em> edited by D. Posada 
(outlines DNA alignment methods and several tips including group-to-group alignment and rough clustering of a large number of sequences)</li>
<li>Katoh, Toh 2008 (<a href="http://www.biomedcentral.com/1471-2105/9/212"><em>BMC Bioinformatics</em> <strong>9</strong>:212</a>) 
Improved accuracy of multiple ncRNA alignment by incorporating structural information into a MAFFT-based framework. 
(describes RNA structural alignment methods)</li>
<li>Katoh, Toh 2008 (<a href="http://bib.oxfordjournals.org/cgi/content/abstract/9/4/286"><em>Briefings in Bioinformatics</em> <strong>9</strong>:286-298</a>) 
Recent developments in the MAFFT multiple sequence alignment program. 
(outlines version 6; <a href="http://sciencewatch.com/dr/fbp/2009/09octfbp/09octfbpKato/">Fast Breaking Paper in Thomson Reuters&#39; ScienceWatch</a>)</li>
<li>Katoh, Toh 2007 (<a href="http://bioinformatics.oxfordjournals.org/cgi/content/abstract/23/3/372"><em>Bioinformatics</em> <strong>23</strong>:372-374</a>) <a href="https://mafft.cbrc.jp/alignment/software/errata.html">Errata</a> 
 PartTree: an algorithm to build an approximate tree from a large number of unaligned sequences. 
 (describes the PartTree algorithm)</li>
<li>Katoh, Kuma, Toh, Miyata 2005 (<a href="https://mafft.cbrc.jp/alignment/server/jump.html?https://academic.oup.com/nar/article-lookup/doi/10.1093/nar/gki198"><em>Nucleic Acids Res.</em> <strong>33</strong>:511-518</a>) 
 MAFFT version 5: improvement in accuracy of multiple sequence alignment. 
 (describes [ancestral versions of] the G-INS-i, L-INS-i and E-INS-i strategies)</li>
<li>Katoh, Misawa, Kuma, Miyata 2002 (<a href="https://mafft.cbrc.jp/alignment/server/jump.html?https://academic.oup.com/nar/article/30/14/3059/2904316/"><em>Nucleic Acids Res.</em> <strong>30</strong>:3059-3066</a>) 
MAFFT: a novel method for rapid multiple sequence alignment based on fast Fourier transform. 
 (describes the FFT-NS-1, FFT-NS-2 and FFT-NS-i strategies)</li>
</ul>

<br>
<br>

</body>

<script type="text/javascript">
    function disabledSubmit() {
        document.getElementById("submitBtn").disabled= true;
        return true;
    }

	function checkEnd(algorithm){
		if(algorithm.value === "FFT-NS-i" || algorithm.value === "E-INS-i" || algorithm.value === "L-INS-i" || algorithm.value === "G-INS-i"){
			document.getElementById("niter").disabled = false;
		}else{
			document.getElementById("niter").disabled = true;
		}

		if(algorithm.value === "Q-INS-i" || algorithm.value === "X-INS-i"){
			document.getElementById("RNA_algorithm").disabled = false;
		}else{
			document.getElementById("RNA_algorithm").disabled = true;
		}

		if(algorithm.value === "X-INS-i"){
			document.getElementById("aligner").disabled = false;
		}else{
			document.getElementById("aligner").disabled = true;
		}


	}
</script>
</html>