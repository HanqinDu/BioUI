<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>QUAST: quality assessment tool for genome assemblies</h4>
Version: 5.0.2
<br>
Reference:<br> 
&nbsp;Alla Mikheenko, Andrey Prjibelski, Vladislav Saveliev, Dmitry Antipov, Alexey Gurevich,<br>
&nbsp;Versatile genome assembly evaluation with QUAST-LG,<br>
&nbsp;Bioinformatics (2018) 34 (13): i142-i150. doi: 10.1093/bioinformatics/bty266
<br>
<br>

<form action="QuastListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>

Lower threshold for contig length (default 500): <input type="text" name="min_contigs" value="">
<br>

Customer parameters (e.g. --plots-format svg): <input type="text" name="parameters" value="">
<br>
<br>

*Upload assembled contigs (.fasta): <input multiple type="file" name="input-contig">

<br>
<br>
<br>

Optional files:
<br>
<br>
Upload Reference genome file (.fasta): <input type="file" name="input-r">
<br>
Upload genomic feature coordinates in the reference (GFF, BED, NCBI or TXT): <input type="file" name="input-g">
<br>
<br>
Upload forward paired-end reads (fasta, gz): <input type="file" name="input--pe1">
<br>
Upload reverse paired-end reads (fasta, gz): <input type="file" name="input--pe2">
<br>
Upload interlaced forward and reverse paired-end reads (fasta, gz): <input type="file" name="input--pe12">
<br>
<br>
Upload forward mate-pair reads (fasta, gz): <input type="file" name="input--mp1">
<br>
Upload reverse mate-pair reads (fasta, gz): <input type="file" name="input--mp2">
<br>
Upload interlaced forward and reverse mate-pair reads (fasta, gz): <input type="file" name="input--mp12">
<br>
<br>
Upload File with unpaired short reads (fasta, gz): <input type="file" name="input--single">
<br>
Upload File with PacBio reads (fasta, gz): <input type="file" name="input--pacbio">
<br>
Upload File with Oxford Nanopore reads (fasta, gz): <input type="file" name="input--nanopore">
<br>
<br>
<br>
Email: <input type="text" name="email" value="">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="abstract">Abstract</h4>
<p><strong>Summary:</strong> Limitations of genome sequencing techniques have led to dozens of assembly algorithms, none of which is perfect. A number of methods for comparing assemblers have been developed, but none is yet a recognized benchmark. Further, most existing methods for comparing assemblies are only applicable to new assemblies of finished genomes; the problem of evaluating assemblies of previously unsequenced species has not been adequately considered. Here, we present QUAST-a quality assessment tool for evaluating and comparing genome assemblies. This tool improves on leading assembly comparison software with new ideas and quality metrics. QUAST can evaluate assemblies both with a reference genome, as well as without a reference. QUAST produces many reports, summary tables and plots to help scientists in their research and in their publications. In this study, we used QUAST to compare several genome assemblers on three datasets. QUAST tables and plots for all of them are available in the Supplementary Material, and interactive versions of these reports are on the QUAST website.</p>
<p><strong>Availability:</strong> <a href="http://bioinf.spbau.ru/quast">http://bioinf.spbau.ru/quast</a> .</p>

<br>
<br>

<h4 id="parameters">Parameters</h4>
<pre><code>Advanced options:
-s  --split-scaffolds                 Split assemblies <span class="hljs-keyword">by</span> continuous fragments <span class="hljs-keyword">of</span> N<span class="hljs-comment">'s and add such "contigs" to the comparison</span>
-l  --labels <span class="hljs-string">"label, label, ..."</span>      Names <span class="hljs-keyword">of</span> assemblies <span class="hljs-keyword">to</span> use <span class="hljs-keyword">in</span> reports, comma-separated. <span class="hljs-keyword">If</span> contain spaces, use quotes
-L                                    <span class="hljs-keyword">Take</span> <span class="hljs-keyword">assembly</span> names <span class="hljs-keyword">from</span> their parent directory names
-e  --eukaryote                       Genome <span class="hljs-keyword">is</span> eukaryotic (primarily affects gene prediction)
    --fungus                          Genome <span class="hljs-keyword">is</span> fungal (primarily affects gene prediction)
    --large                           Use optimal parameters <span class="hljs-keyword">for</span> evaluation <span class="hljs-keyword">of</span> large genomes
                                      <span class="hljs-keyword">In</span> particular, imposes <span class="hljs-comment">'-e -m 3000 -i 500 -x 7000' (can be overridden manually)</span>
-k  --k-mer-stats                     Compute k-mer-based quality metrics (recommended <span class="hljs-keyword">for</span> large genomes)
                                      This may significantly increase memory <span class="hljs-keyword">and</span> time consumption <span class="hljs-keyword">on</span> large genomes
    --k-mer-size                      Size <span class="hljs-keyword">of</span> k used <span class="hljs-keyword">in</span> --k-mer-stats [<span class="hljs-keyword">default</span>: <span class="hljs-number">101</span>]
    --circos                          Draw Circos plot
-f  --gene-finding                    Predict genes <span class="hljs-keyword">using</span> GeneMarkS (prokaryotes, <span class="hljs-keyword">default</span>) <span class="hljs-keyword">or</span> GeneMark-ES (eukaryotes, use --eukaryote)
    --mgm                             Use MetaGeneMark <span class="hljs-keyword">for</span> gene prediction (instead <span class="hljs-keyword">of</span> the <span class="hljs-keyword">default</span> finder, see above)
    --glimmer                         Use GlimmerHMM <span class="hljs-keyword">for</span> gene prediction (instead <span class="hljs-keyword">of</span> the <span class="hljs-keyword">default</span> finder, see above)
    --gene-thresholds &lt;int,int,...&gt;   Comma-separated list <span class="hljs-keyword">of</span> threshold lengths <span class="hljs-keyword">of</span> genes <span class="hljs-keyword">to</span> search <span class="hljs-keyword">with</span> Gene Finding <span class="hljs-keyword">module</span>
                                      [<span class="hljs-keyword">default</span>: <span class="hljs-number">0</span>,<span class="hljs-number">300</span>,<span class="hljs-number">1500</span>,<span class="hljs-number">3000</span>]
    --rna-finding                     Predict ribosomal RNA genes <span class="hljs-keyword">using</span> Barrnap
-b  --conserved-genes-finding         Count conserved orthologs <span class="hljs-keyword">using</span> BUSCO (only <span class="hljs-keyword">on</span> Linux)
    --operons  &lt;filename&gt;             File <span class="hljs-keyword">with</span> operon coordinates <span class="hljs-keyword">in</span> the reference (GFF, BED, NCBI <span class="hljs-keyword">or</span> TXT)
    --est-ref-size &lt;int&gt;              Estimated reference size (<span class="hljs-keyword">for</span> computing NGx metrics without a reference)
    --contig-thresholds &lt;int,int,...&gt; Comma-separated list <span class="hljs-keyword">of</span> contig length thresholds [<span class="hljs-keyword">default</span>: <span class="hljs-number">0</span>,<span class="hljs-number">1000</span>,<span class="hljs-number">5000</span>,<span class="hljs-number">10000</span>,<span class="hljs-number">25000</span>,<span class="hljs-number">50000</span>]
-u  --use-all-alignments              Compute genome fraction, <span class="hljs-meta"># genes, # operons in QUAST v1.* style.</span>
                                      <span class="hljs-keyword">By</span> <span class="hljs-keyword">default</span>, QUAST filters Minimap<span class="hljs-comment">'s alignments to keep only best ones</span>
-i  --min-alignment &lt;int&gt;             The minimum alignment length [<span class="hljs-keyword">default</span>: <span class="hljs-number">65</span>]
    --min-identity &lt;float&gt;            The minimum alignment identity (<span class="hljs-number">80.0</span>, <span class="hljs-number">100.0</span>) [<span class="hljs-keyword">default</span>: <span class="hljs-number">95.0</span>]
-a  --ambiguity-usage &lt;none|one|all&gt;  Use none, one, <span class="hljs-keyword">or</span> all alignments <span class="hljs-keyword">of</span> a contig <span class="hljs-keyword">when</span> all <span class="hljs-keyword">of</span> them
                                      are almost equally good (see --ambiguity-score) [<span class="hljs-keyword">default</span>: one]
    --ambiguity-score &lt;float&gt;         Score S <span class="hljs-keyword">for</span> defining equally good alignments <span class="hljs-keyword">of</span> a <span class="hljs-built_in">single</span> contig. All alignments are sorted
                                      <span class="hljs-keyword">by</span> decreasing LEN * IDY% value. All alignments <span class="hljs-keyword">with</span> LEN * IDY% &lt; S * best(LEN * IDY%) are
                                      discarded. S should be between <span class="hljs-number">0.8</span> <span class="hljs-keyword">and</span> <span class="hljs-number">1.0</span> [<span class="hljs-keyword">default</span>: <span class="hljs-number">0.99</span>]
    --<span class="hljs-keyword">strict</span>-NA                       Break contigs <span class="hljs-keyword">in</span> any misassembly <span class="hljs-keyword">event</span> <span class="hljs-keyword">when</span> compute NAx <span class="hljs-keyword">and</span> NGAx.
                                      <span class="hljs-keyword">By</span> <span class="hljs-keyword">default</span>, QUAST breaks contigs only <span class="hljs-keyword">by</span> extensive misassemblies (<span class="hljs-keyword">not</span> local ones)
-x  --extensive-mis-size  &lt;int&gt;       Lower threshold <span class="hljs-keyword">for</span> extensive misassembly size. All relocations <span class="hljs-keyword">with</span> inconsistency
                                      less than extensive-mis-size are counted <span class="hljs-keyword">as</span> local misassemblies [<span class="hljs-keyword">default</span>: <span class="hljs-number">1000</span>]
    --scaffold-gap-max-size  &lt;int&gt;    Max allowed scaffold gap length difference. All relocations <span class="hljs-keyword">with</span> inconsistency
                                      less than scaffold-gap-size are counted <span class="hljs-keyword">as</span> scaffold gap misassemblies [<span class="hljs-keyword">default</span>: <span class="hljs-number">10000</span>]
    --unaligned-part-size  &lt;int&gt;      Lower threshold <span class="hljs-keyword">for</span> detecting partially unaligned contigs. Such contig should have
                                      at least one unaligned fragment &gt;= the threshold [<span class="hljs-keyword">default</span>: <span class="hljs-number">500</span>]
    --<span class="hljs-keyword">skip</span>-unaligned-mis-contigs      <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> distinguish contigs <span class="hljs-keyword">with</span> &gt;= <span class="hljs-number">50</span>% unaligned bases <span class="hljs-keyword">as</span> a separate <span class="hljs-keyword">group</span>
                                      <span class="hljs-keyword">By</span> <span class="hljs-keyword">default</span>, QUAST does <span class="hljs-keyword">not</span> count misassemblies <span class="hljs-keyword">in</span> them
    --fragmented                      Reference genome may be fragmented <span class="hljs-keyword">into</span> small pieces (e.g. scaffolded reference)
    --fragmented-max-indent  &lt;int&gt;    Mark translocation <span class="hljs-keyword">as</span> fake <span class="hljs-keyword">if</span> both alignments are located no further than N bases
                                      <span class="hljs-keyword">from</span> the ends <span class="hljs-keyword">of</span> the reference fragments [<span class="hljs-keyword">default</span>: <span class="hljs-number">85</span>]
                                      Requires --fragmented <span class="hljs-keyword">option</span>
    --upper-bound-<span class="hljs-keyword">assembly</span>            Simulate upper bound <span class="hljs-keyword">assembly</span> based <span class="hljs-keyword">on</span> the reference genome <span class="hljs-keyword">and</span> reads
    --upper-bound-min-con  &lt;int&gt;      Minimal number <span class="hljs-keyword">of</span> <span class="hljs-comment">'connecting reads' needed for joining upper bound contigs into a scaffold</span>
                                      [<span class="hljs-keyword">default</span>: <span class="hljs-number">2</span> <span class="hljs-keyword">for</span> mate-pairs <span class="hljs-keyword">and</span> <span class="hljs-number">1</span> <span class="hljs-keyword">for</span> <span class="hljs-built_in">long</span> reads]
    --est-insert-size  &lt;int&gt;          Use provided insert size <span class="hljs-keyword">in</span> upper bound <span class="hljs-keyword">assembly</span> simulation [<span class="hljs-keyword">default</span>: <span class="hljs-keyword">auto</span> detect <span class="hljs-keyword">from</span> reads <span class="hljs-keyword">or</span> <span class="hljs-number">255</span>]
    --plots-format  &lt;str&gt;             Save plots <span class="hljs-keyword">in</span> specified format [<span class="hljs-keyword">default</span>: pdf].
                                      Supported formats: emf, eps, pdf, png, ps, raw, rgba, svg, svgz
    --memory-efficient                Run everything <span class="hljs-keyword">using</span> one thread, separately per <span class="hljs-keyword">each</span> <span class="hljs-keyword">assembly</span>.
                                      This may significantly reduce memory consumption <span class="hljs-keyword">on</span> large genomes
    --space-efficient                 Create only reports <span class="hljs-keyword">and</span> plots files. Aux files including .stdout, .stderr, .coords will <span class="hljs-keyword">not</span> be created.
                                      This may significantly reduce space consumption <span class="hljs-keyword">on</span> large genomes. Icarus viewers also will <span class="hljs-keyword">not</span> be built

Speedup options:
    --no-check                        <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> check <span class="hljs-keyword">and</span> correct input fasta files. Use at your own risk (see manual)
    --no-plots                        <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> draw plots
    --no-html                         <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> build html reports <span class="hljs-keyword">and</span> Icarus viewers
    --no-icarus                       <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> build Icarus viewers
    --no-snps                         <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> report SNPs (may significantly reduce memory consumption <span class="hljs-keyword">on</span> large genomes)
    --no-gc                           <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> compute GC% <span class="hljs-keyword">and</span> GC-distribution
    --no-sv                           <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> run structural variation detection (make sense only <span class="hljs-keyword">if</span> reads are specified)
    --no-gzip                         <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> compress large output files
    --no-read-stats                   <span class="hljs-keyword">Do</span> <span class="hljs-keyword">not</span> align reads <span class="hljs-keyword">to</span> assemblies
                                      Reads will be aligned <span class="hljs-keyword">to</span> reference <span class="hljs-keyword">and</span> used <span class="hljs-keyword">for</span> coverage analysis,
                                      upper bound <span class="hljs-keyword">assembly</span> simulation, <span class="hljs-keyword">and</span> structural variation detection.
                                      Use this <span class="hljs-keyword">option</span> <span class="hljs-keyword">if</span> you <span class="hljs-keyword">do</span> <span class="hljs-keyword">not</span> need read statistics <span class="hljs-keyword">for</span> assemblies.
    --fast                            A combination <span class="hljs-keyword">of</span> all speedup options except --no-check
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