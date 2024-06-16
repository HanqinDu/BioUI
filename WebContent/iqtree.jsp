<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>IQ-TREE 2: New Models and Efficient Methods for Phylogenetic Inference in the Genomic Era</h4>
Version: 2.1.4
<br>
Reference: <a href="https://academic.oup.com/mbe/article/37/5/1530/5721363" target="_blank">https://doi.org/10.1093/molbev/msaa131</a>
<br>
Document: <a href="http://www.iqtree.org/doc/" target="_blank">http://www.iqtree.org/doc/</a>
<br>
<br>
<form action="IQTREEListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>

Customer parameters (e.g. --epsilon 0.1): <input type="text" name="parameters" value="">
<br>
<br>

*Upload alignment files: <input multiple type="file" name="input1">
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
<p>IQ-TREE (<a href="http://www.iqtree.org/">http://www.iqtree.org, last accessed February 6, 2020</a>) is a user-friendly and widely used software package for phylogenetic inference using maximum likelihood. Since the release of version 1 in 2014, we have continuously expanded IQ-TREE to integrate a plethora of new models of sequence evolution and efficient computational approaches of phylogenetic inference to deal with genomic data. Here, we describe notable features of IQ-TREE version 2 and highlight the key advantages over other software.</p>

<br>
<br>

<h4 id="parameters">Parameters</h4>
<pre><code>GENERAL OPTIONS:
  -<span class="ruby">h, --help           Print (more) help usages
</span>  -<span class="ruby">s FILE[,...,FILE]   PHYLIP/FASTA/NEXUS/CLUSTAL/MSF alignment file(s)
</span>  -<span class="ruby">s DIR               Directory of alignment files
</span>  -<span class="ruby">-seqtype STRING     BIN, DNA, AA, NT2AA, CODON, MORPH (<span class="hljs-symbol">default:</span> auto-detect)
</span>  -<span class="ruby">t FILE<span class="hljs-params">|PARS|</span>RAND    Starting tree (<span class="hljs-symbol">default:</span> <span class="hljs-number">99</span> parsimony <span class="hljs-keyword">and</span> BIONJ)
</span>  -<span class="ruby">o TAX[,...,TAX]     Outgroup taxon (list) <span class="hljs-keyword">for</span> writing .treefile
</span>  -<span class="ruby">-prefix STRING      Prefix <span class="hljs-keyword">for</span> all output files (<span class="hljs-symbol">default:</span> aln/partition)
</span>  -<span class="ruby">-seed NUM           Random seed number, normally used <span class="hljs-keyword">for</span> debugging purpose
</span>  -<span class="ruby">-safe               Safe likelihood kernel to avoid numerical underflow
</span>  -<span class="ruby">-mem NUM[G<span class="hljs-params">|M|</span>%]     Maximal RAM usage <span class="hljs-keyword">in</span> GB <span class="hljs-params">| MB |</span> %
</span>  -<span class="ruby">-runs NUM           Number of indepedent runs (<span class="hljs-symbol">default:</span> <span class="hljs-number">1</span>)
</span>  -<span class="ruby">v, --verbose        Verbose mode, printing more messages to screen
</span>  -<span class="ruby">V, --version        Display version number
</span>  -<span class="ruby">-quiet              Quiet mode, suppress printing to screen (stdout)
</span>  -<span class="ruby">fconst f1,...,fN    Add constant patterns into alignment (N=no. states)
</span>  -<span class="ruby">-epsilon NUM        Likelihood epsilon <span class="hljs-keyword">for</span> parameter estimate (default <span class="hljs-number">0</span>.<span class="hljs-number">01</span>)
</span>  -<span class="ruby">T NUM<span class="hljs-params">|AUTO          No. cores/threads <span class="hljs-keyword">or</span> AUTO-detect (default: 1)
</span></span>  -<span class="ruby"><span class="hljs-params">-threads-max NUM    Max number of threads <span class="hljs-keyword">for</span> -T AUTO (default: all cores)
</span></span>
CHECKPOINT:
  -<span class="ruby"><span class="hljs-params">-<span class="hljs-keyword">redo</span>               Redo both ModelFinder <span class="hljs-keyword">and</span> tree search
</span></span>  -<span class="ruby"><span class="hljs-params">-<span class="hljs-keyword">redo</span>-tree          Restore ModelFinder <span class="hljs-keyword">and</span> only <span class="hljs-keyword">redo</span> tree search
</span></span>  -<span class="ruby"><span class="hljs-params">-undo               Revoke finished run, used <span class="hljs-keyword">when</span> changing some options
</span></span>  -<span class="ruby"><span class="hljs-params">-cptime NUM         Minimum checkpoint interval (default: 60 sec <span class="hljs-keyword">and</span> adapt)
</span></span>
PARTITION MODEL:
  -<span class="ruby"><span class="hljs-params">p FILE|</span>DIR          NEXUS/RAxML partition file <span class="hljs-keyword">or</span> directory with alignments
</span>                       Edge-linked proportional partition model
  -<span class="ruby">q FILE<span class="hljs-params">|DIR          Like -p but edge-linked equal partition model
</span></span>  -<span class="ruby"><span class="hljs-params">Q FILE|</span>DIR          Like -p but edge-unlinked partition model
</span>  -<span class="ruby">S FILE<span class="hljs-params">|DIR          Like -p but separate tree inference
</span></span>  -<span class="ruby"><span class="hljs-params">-subsample NUM      Randomly sub-sample partitions (negative <span class="hljs-keyword">for</span> complement)
</span></span>  -<span class="ruby"><span class="hljs-params">-subsample-seed NUM Random number seed <span class="hljs-keyword">for</span> --subsample
</span></span>
LIKELIHOOD/QUARTET MAPPING:
  -<span class="ruby"><span class="hljs-params">-lmap NUM           Number of quartets <span class="hljs-keyword">for</span> likelihood mapping analysis
</span></span>  -<span class="ruby"><span class="hljs-params">-lmclust FILE       NEXUS file containing clusters <span class="hljs-keyword">for</span> likelihood mapping
</span></span>  -<span class="ruby"><span class="hljs-params">-quartetlh          Print quartet log-likelihoods to .quartetlh file
</span></span>
TREE SEARCH ALGORITHM:
  -<span class="ruby"><span class="hljs-params">-ninit NUM          Number of initial parsimony trees (default: 100)
</span></span>  -<span class="ruby"><span class="hljs-params">-ntop NUM           Number of top initial trees (default: 20)
</span></span>  -<span class="ruby"><span class="hljs-params">-nbest NUM          Number of best trees retained during search (defaut: 5)
</span></span>  -<span class="ruby"><span class="hljs-params">n NUM               Fix number of iterations to stop (default: OFF)
</span></span>  -<span class="ruby"><span class="hljs-params">-nstop NUM          Number of unsuccessful iterations to stop (default: 100)
</span></span>  -<span class="ruby"><span class="hljs-params">-perturb NUM        Perturbation strength <span class="hljs-keyword">for</span> randomized NNI (default: 0.5)
</span></span>  -<span class="ruby"><span class="hljs-params">-radius NUM         Radius <span class="hljs-keyword">for</span> parsimony SPR search (default: 6)
</span></span>  -<span class="ruby"><span class="hljs-params">-allnni             Perform more thorough NNI search (default: OFF)
</span></span>  -<span class="ruby"><span class="hljs-params">g FILE              (Multifurcating) topological constraint tree file
</span></span>  -<span class="ruby"><span class="hljs-params">-fast               Fast search to resemble FastTree
</span></span>  -<span class="ruby"><span class="hljs-params">-polytomy           Collapse near-zero branches into polytomy
</span></span>  -<span class="ruby"><span class="hljs-params">-tree-fix           Fix -t tree (no tree search performed)
</span></span>  -<span class="ruby"><span class="hljs-params">-treels             Write locally optimal trees into .treels file
</span></span>  -<span class="ruby"><span class="hljs-params">-show-lh            Compute tree likelihood without optimisation
</span></span>  -<span class="ruby"><span class="hljs-params">-terrace            Check <span class="hljs-keyword">if</span> the tree lies on a phylogenetic terrace
</span></span>
ULTRAFAST BOOTSTRAP/JACKKNIFE:
  -<span class="ruby"><span class="hljs-params">B, --ufboot NUM     Replicates <span class="hljs-keyword">for</span> ultrafast bootstrap (&gt;=1000)
</span></span>  -<span class="ruby"><span class="hljs-params">J, --ufjack NUM     Replicates <span class="hljs-keyword">for</span> ultrafast jackknife (&gt;=1000)
</span></span>  -<span class="ruby"><span class="hljs-params">-jack-prop NUM      Subsampling proportion <span class="hljs-keyword">for</span> jackknife (default: 0.5)
</span></span>  -<span class="ruby"><span class="hljs-params">-sampling STRING    GENE|</span>GENESITE resampling <span class="hljs-keyword">for</span> partitions (<span class="hljs-symbol">default:</span> SITE)
</span>  -<span class="ruby">-boot-trees         Write bootstrap trees to .ufboot file (<span class="hljs-symbol">default:</span> none)
</span>  -<span class="ruby">-wbtl               Like --boot-trees but also writing branch lengths
</span>  -<span class="ruby">-nmax NUM           Maximum number of iterations (<span class="hljs-symbol">default:</span> <span class="hljs-number">1000</span>)
</span>  -<span class="ruby">-nstep NUM          Iterations <span class="hljs-keyword">for</span> UFBoot stopping rule (<span class="hljs-symbol">default:</span> <span class="hljs-number">100</span>)
</span>  -<span class="ruby">-bcor NUM           Minimum correlation coefficient (<span class="hljs-symbol">default:</span> <span class="hljs-number">0</span>.<span class="hljs-number">99</span>)
</span>  -<span class="ruby">-beps NUM           RELL epsilon to <span class="hljs-keyword">break</span> tie (<span class="hljs-symbol">default:</span> <span class="hljs-number">0</span>.<span class="hljs-number">5</span>)
</span>  -<span class="ruby">-bnni               Optimize UFBoot trees by NNI on bootstrap alignment
</span>
NON-PARAMETRIC BOOTSTRAP/JACKKNIFE:
  -<span class="ruby">b, --boot NUM       Replicates <span class="hljs-keyword">for</span> bootstrap + ML tree + consensus tree
</span>  -<span class="ruby">j, --jack NUM       Replicates <span class="hljs-keyword">for</span> jackknife + ML tree + consensus tree
</span>  -<span class="ruby">-jack-prop NUM      Subsampling proportion <span class="hljs-keyword">for</span> jackknife (<span class="hljs-symbol">default:</span> <span class="hljs-number">0</span>.<span class="hljs-number">5</span>)
</span>  -<span class="ruby">-bcon NUM           Replicates <span class="hljs-keyword">for</span> bootstrap + consensus tree
</span>  -<span class="ruby">-bonly NUM          Replicates <span class="hljs-keyword">for</span> bootstrap only
</span>  -<span class="ruby">-tbe                Transfer bootstrap expectation
</span>
SINGLE BRANCH TEST:
  -<span class="ruby">-alrt NUM           Replicates <span class="hljs-keyword">for</span> SH approximate likelihood ratio test
</span>  -<span class="ruby">-alrt <span class="hljs-number">0</span>             Parametric aLRT test (Anisimova <span class="hljs-keyword">and</span> Gascuel <span class="hljs-number">2006</span>)
</span>  -<span class="ruby">-abayes             approximate Bayes test (Anisimova et al. <span class="hljs-number">2011</span>)
</span>  -<span class="ruby">-lbp NUM            Replicates <span class="hljs-keyword">for</span> fast local bootstrap probabilities
</span>
MODEL-FINDER:
  -<span class="ruby">m TESTONLY          Standard model selection (like jModelTest, ProtTest)
</span>  -<span class="ruby">m TEST              Standard model selection followed by tree inference
</span>  -<span class="ruby">m MF                Extended model selection with FreeRate heterogeneity
</span>  -<span class="ruby">m MFP               Extended model selection followed by tree inference
</span>  -<span class="ruby">m ...+LM            Additionally test Lie Markov models
</span>  -<span class="ruby">m ...+LMRY          Additionally test Lie Markov models with RY symmetry
</span>  -<span class="ruby">m ...+LMWS          Additionally test Lie Markov models with WS symmetry
</span>  -<span class="ruby">m ...+LMMK          Additionally test Lie Markov models with MK symmetry
</span>  -<span class="ruby">m ...+LMSS          Additionally test strand-symmetric models
</span>  -<span class="ruby">-mset STRING        Restrict search to models supported by other programs
</span>                       (raxml, phyml or mrbayes)
  -<span class="ruby">-mset STR,...       Comma-separated model list (e.g. -mset WAG,LG,JTT)
</span>  -<span class="ruby">-msub STRING        Amino-acid model source
</span>                       (nuclear, mitochondrial, chloroplast or viral)
  -<span class="ruby">-mfreq STR,...      List of state frequencies
</span>  -<span class="ruby">-mrate STR,...      List of rate heterogeneity among sites
</span>                       (e.g. -mrate E,I,G,I+G,R is used for -m MF)
  -<span class="ruby">-cmin NUM           Min categories <span class="hljs-keyword">for</span> FreeRate model [+R] (<span class="hljs-symbol">default:</span> <span class="hljs-number">2</span>)
</span>  -<span class="ruby">-cmax NUM           Max categories <span class="hljs-keyword">for</span> FreeRate model [+R] (<span class="hljs-symbol">default:</span> <span class="hljs-number">10</span>)
</span>  -<span class="ruby">-merit AIC<span class="hljs-params">|AICc|</span>BIC  Akaike<span class="hljs-params">|Bayesian information criterion (default: BIC)
</span></span>  -<span class="ruby"><span class="hljs-params">-mtree              Perform full tree search <span class="hljs-keyword">for</span> every model
</span></span>  -<span class="ruby"><span class="hljs-params">-madd STR,...       List of mixture models to consider
</span></span>  -<span class="ruby"><span class="hljs-params">-mdef FILE          Model definition NEXUS file (see Manual)
</span></span>  -<span class="ruby"><span class="hljs-params">-modelomatic        Find best codon/protein/DNA models (Whelan et al. 2015)
</span></span>
PARTITION-FINDER:
  -<span class="ruby"><span class="hljs-params">-merge              Merge partitions to increase model fit
</span></span>  -<span class="ruby"><span class="hljs-params">-merge greedy|</span>rcluster<span class="hljs-params">|rclusterf
</span></span>                       Set merging algorithm (default: rclusterf)
  -<span class="ruby"><span class="hljs-params">-merge-model 1|</span>all  Use only <span class="hljs-number">1</span> <span class="hljs-keyword">or</span> all models <span class="hljs-keyword">for</span> merging (<span class="hljs-symbol">default:</span> <span class="hljs-number">1</span>)
</span>  -<span class="ruby">-merge-model STR,...
</span>                       Comma-separated model list for merging
  -<span class="ruby">-merge-rate <span class="hljs-number">1</span><span class="hljs-params">|all   Use only 1 <span class="hljs-keyword">or</span> all rate heterogeneity (default: 1)
</span></span>  -<span class="ruby"><span class="hljs-params">-merge-rate STR,...
</span></span>                       Comma-separated rate list for merging
  -<span class="ruby"><span class="hljs-params">-rcluster NUM       Percentage of partition pairs <span class="hljs-keyword">for</span> rcluster algorithm
</span></span>  -<span class="ruby"><span class="hljs-params">-rclusterf NUM      Percentage of partition pairs <span class="hljs-keyword">for</span> rclusterf algorithm
</span></span>  -<span class="ruby"><span class="hljs-params">-rcluster-max NUM   Max number of partition pairs (default: 10*partitions)
</span></span>
SUBSTITUTION MODEL:
  -<span class="ruby"><span class="hljs-params">m STRING            Model name string (e.g. GTR+F+I+G)
</span></span>                 DNA:  HKY (default), JC, F81, K2P, K3P, K81uf, TN/TrN, TNef,
                       TIM, TIMef, TVM, TVMef, SYM, GTR, or 6-digit model
                       specification (e.g., 010010 = HKY)
             Protein:  LG (default), Poisson, cpREV, mtREV, Dayhoff, mtMAM,
                       JTT, WAG, mtART, mtZOA, VT, rtREV, DCMut, PMB, HIVb,
                       HIVw, JTTDCMut, FLU, Blosum62, GTR20, mtMet, mtVer, mtInv, FLAVI,
                        Q.LG, Q.pfam, Q.pfam_gb, Q.bird, Q.mammal, Q.insect, Q.plant, Q.yeast
     Protein mixture:  C10,...,C60, EX2, EX3, EHO, UL2, UL3, EX_EHO, LG4M, LG4X
              Binary:  JC2 (default), GTR2
     Empirical codon:  KOSI07, SCHN05
   Mechanistic codon:  GY (default), MG, MGK, GY0K, GY1KTS, GY1KTV, GY2K,
                       MG1KTS, MG1KTV, MG2K
Semi-empirical codon:  XX_YY where XX is empirical and YY is mechanistic model
      Morphology/SNP:  MK (default), ORDERED, GTR
      Lie Markov DNA:  1.1, 2.2b, 3.3a, 3.3b, 3.3c, 3.4, 4.4a, 4.4b, 4.5a,
                       4.5b, 5.6a, 5.6b, 5.7a, 5.7b, 5.7c, 5.11a, 5.11b, 5.11c,
                       5.16, 6.6, 6.7a, 6.7b, 6.8a, 6.8b, 6.17a, 6.17b, 8.8,
                       8.10a, 8.10b, 8.16, 8.17, 8.18, 9.20a, 9.20b, 10.12,
                       10.34, 12.12 (optionally prefixed by RY, WS or MK)
      Non-reversible:  STRSYM (strand symmetric model, equiv. WS6.6),
                       NONREV, UNREST (unrestricted model, equiv. 12.12)
           Otherwise:  Name of file containing user-model parameters

STATE FREQUENCY:
  -<span class="ruby"><span class="hljs-params">m ...+F             Empirically counted frequencies from alignment
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+FO            Optimized frequencies by maximum-likelihood
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+FQ            Equal frequencies
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+FRY           For DNA, freq(A+G)=1/2=freq(C+T)
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+FWS           For DNA, freq(A+T)=1/2=freq(C+G)
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+FMK           For DNA, freq(A+C)=1/2=freq(G+T)
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+Fabcd         4-digit constraint on ACGT frequency
</span></span>                       (e.g. +F1221 means f_A=f_T, f_C=f_G)
  -<span class="ruby"><span class="hljs-params">m ...+FU            Amino-acid frequencies given protein matrix
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+F1x4          Equal NT frequencies over three codon positions
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+F3x4          Unequal NT frequencies over three codon positions
</span></span>
RATE HETEROGENEITY AMONG SITES:
  -<span class="ruby"><span class="hljs-params">m ...+I             A proportion of invariable sites
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+G[n]          Discrete Gamma model with n categories (default n=4)
</span></span>  -<span class="ruby"><span class="hljs-params">m ...*G[n]          Discrete Gamma model with unlinked model parameters
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+I+G[n]        Invariable sites plus Gamma model with n categories
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+R[n]          FreeRate model with n categories (default n=4)
</span></span>  -<span class="ruby"><span class="hljs-params">m ...*R[n]          FreeRate model with unlinked model parameters
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+I+R[n]        Invariable sites plus FreeRate model with n categories
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+Hn            Heterotachy model with n classes
</span></span>  -<span class="ruby"><span class="hljs-params">m ...*Hn            Heterotachy model with n classes <span class="hljs-keyword">and</span> unlinked parameters
</span></span>  -<span class="ruby"><span class="hljs-params">-alpha-min NUM      Min Gamma shape parameter <span class="hljs-keyword">for</span> site rates (default: 0.02)
</span></span>  -<span class="ruby"><span class="hljs-params">-gamma-median       Median approximation <span class="hljs-keyword">for</span> +G site rates (default: mean)
</span></span>  -<span class="ruby"><span class="hljs-params">-rate               Write empirical Bayesian site rates to .rate file
</span></span>  -<span class="ruby"><span class="hljs-params">-mlrate             Write maximum likelihood site rates to .mlrate file
</span></span>
POLYMORPHISM AWARE MODELS (PoMo):
  -<span class="ruby"><span class="hljs-params">s FILE              Input counts file (see manual)
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+P             DNA substitution model (see above) used with PoMo
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+N&lt;POPSIZE&gt;    Virtual population size (default: 9)
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+WB|</span>WH<span class="hljs-params">|S]      Weighted binomial sampling
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+WH            Weighted hypergeometric sampling
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+S             Sampled sampling
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+G[n]          Discrete Gamma rate with n categories (default n=4)
</span></span>
COMPLEX MODELS:
  -<span class="ruby"><span class="hljs-params">m "MIX{m1,...,mK}"  Mixture model with K components
</span></span>  -<span class="ruby"><span class="hljs-params">m "FMIX{f1,...fK}"  Frequency mixture model with K components
</span></span>  -<span class="ruby"><span class="hljs-params">-mix-opt            Optimize mixture weights (default: detect)
</span></span>  -<span class="ruby"><span class="hljs-params">m ...+ASC           Ascertainment bias correction
</span></span>  -<span class="ruby"><span class="hljs-params">-tree-freq FILE     Input tree to infer site frequency model
</span></span>  -<span class="ruby"><span class="hljs-params">-site-freq FILE     Input site frequency model file
</span></span>  -<span class="ruby"><span class="hljs-params">-freq-max           Posterior maximum instead of mean approximation
</span></span>
TREE TOPOLOGY TEST:
  -<span class="ruby"><span class="hljs-params">-trees FILE         Set of trees to evaluate log-likelihoods
</span></span>  -<span class="ruby"><span class="hljs-params">-test NUM           Replicates <span class="hljs-keyword">for</span> topology test
</span></span>  -<span class="ruby"><span class="hljs-params">-test-weight        Perform weighted KH <span class="hljs-keyword">and</span> SH tests
</span></span>  -<span class="ruby"><span class="hljs-params">-test-au            Approximately unbiased (AU) test (Shimodaira 2002)
</span></span>  -<span class="ruby"><span class="hljs-params">-sitelh             Write site log-likelihoods to .sitelh file
</span></span>
ANCESTRAL STATE RECONSTRUCTION:
  -<span class="ruby"><span class="hljs-params">-ancestral          Ancestral state reconstruction by empirical Bayes
</span></span>  -<span class="ruby"><span class="hljs-params">-asr-min NUM        Min probability of ancestral state (default: equil freq)
</span></span>
TEST OF SYMMETRY:
  -<span class="ruby"><span class="hljs-params">-symtest               Perform three tests of symmetry
</span></span>  -<span class="ruby"><span class="hljs-params">-symtest-only          Do --symtest <span class="hljs-keyword">then</span> exist
</span></span>  -<span class="ruby"><span class="hljs-params">-symtest-remove-bad    Do --symtest <span class="hljs-keyword">and</span> remove bad partitions
</span></span>  -<span class="ruby"><span class="hljs-params">-symtest-remove-good   Do --symtest <span class="hljs-keyword">and</span> remove good partitions
</span></span>  -<span class="ruby"><span class="hljs-params">-symtest-type MAR|</span>INT  Use MARginal/INTernal test <span class="hljs-keyword">when</span> removing partitions
</span>  -<span class="ruby">-symtest-pval NUMER    P-value cutoff (<span class="hljs-symbol">default:</span> <span class="hljs-number">0</span>.<span class="hljs-number">05</span>)
</span>  -<span class="ruby">-symtest-keep-zero     Keep NAs <span class="hljs-keyword">in</span> the tests
</span>
CONCORDANCE FACTOR ANALYSIS:
  -<span class="ruby">t FILE              Reference tree to assign concordance factor
</span>  -<span class="ruby">-gcf FILE           Set of source trees <span class="hljs-keyword">for</span> gene concordance factor (gCF)
</span>  -<span class="ruby">-df-tree            Write discordant trees associated with gDF1
</span>  -<span class="ruby">-scf NUM            Number of quartets <span class="hljs-keyword">for</span> site concordance factor (sCF)
</span>  -<span class="ruby">s FILE              Sequence alignment <span class="hljs-keyword">for</span> --scf
</span>  -<span class="ruby">p FILE<span class="hljs-params">|DIR          Partition file <span class="hljs-keyword">or</span> directory <span class="hljs-keyword">for</span> --scf
</span></span>  -<span class="ruby"><span class="hljs-params">-cf-verbose         Write CF per tree/locus to cf.stat_tree/_loci
</span></span>  -<span class="ruby"><span class="hljs-params">-cf-quartet         Write sCF <span class="hljs-keyword">for</span> all resampled quartets to .cf.quartet
</span></span>
TIME TREE RECONSTRUCTION:
  -<span class="ruby"><span class="hljs-params">-date FILE          File containing dates of tips <span class="hljs-keyword">or</span> ancestral nodes
</span></span>  -<span class="ruby"><span class="hljs-params">-date TAXNAME       Extract dates from taxon names after last '|</span><span class="hljs-string">'
</span></span>  -<span class="ruby"><span class="hljs-string">-date-tip STRING    Tip dates as a real number or YYYY-MM-DD
</span></span>  -<span class="ruby"><span class="hljs-string">-date-root STRING   Root date as a real number or YYYY-MM-DD
</span></span>  -<span class="ruby"><span class="hljs-string">-date-ci NUM        Number of replicates to compute confidence interval
</span></span>  -<span class="ruby"><span class="hljs-string">-clock-sd NUM       Std-dev for lognormal relaxed clock (default: 0.2)
</span></span>  -<span class="ruby"><span class="hljs-string">-date-no-outgroup   Exclude outgroup from time tree
</span></span>  -<span class="ruby"><span class="hljs-string">-date-outlier NUM   Z-score cutoff to remove outlier tips/nodes (e.g. 3)
</span></span>  -<span class="ruby"><span class="hljs-string">-date-options ".."  Extra options passing directly to LSD2
</span></span>  -<span class="ruby"><span class="hljs-string">-dating STRING      Dating method: LSD for least square dating (default)</span></span>
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