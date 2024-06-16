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
<h4>QIIME 2: Calculate and explore diversity metrics</h4>
Version: 2022.2

<br>
<br>

<ul>
    <li><a href="qiime_import.jsp">import data</a></li>
    <li><a href="QiimeQueryListener?step=quality_control&amp;taskname=${requestScope.taskname}">quality control</a></li>
    <li><a href="QiimeQueryListener?step=cluster&amp;taskname=${requestScope.taskname}">cluster OTUs</a></li>
    <li><a href="QiimeQueryListener?step=phylogeny&amp;taskname=${requestScope.taskname}">phylogenic analysis</a></li>
    <li><strong>diversity analyisis</strong></li>
    <li><a href="QiimeQueryListener?step=taxonomy&amp;taskname=${requestScope.taskname}">taxonomy assignment</a></li>
</ul>

<br>
    

<form action="QiimeDiversityListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" id="task" value=${requestScope.taskname}>

<br>
<br>



*Categorical sample metadata column name(s):
<span class="wrapper">[?]
    <div class="tooltip">For multiple group strategy, seperated the column name by space " ". Note that you can review the metadata.tsv and look for an reasonable column for grouping by.</div>
</span>
: <input type="text" name="m-metadata-column" value = "" required>


<br>

*Rarefied sampling-depth for computing diversity metrics
<span class="wrapper">[?]
    <div class="tooltip">The total frequency that each sample should be rarefied to prior to computing diversity metrics. Note that you should input a sample-depth value based on the alpha-rarefaction analysis that you ran in previous step</div>
</span>
: <input type="text" name="sampling-depth" value="" required>


<br>
<br>





Perform tests between all pairs of groups (slow): <input type="checkbox" name="pairwise" value="pairwise"> 

<br>

The group significance test to be applied: <input name="p-method" list="p-method">
<datalist id="p-method">
	<option value="permanova">
    <option value="anosim">
    <option value="permdisp">
</datalist>

<br>



The number of permutations to be run when computing p-values: <input type="text" name="p-permutations" value = "">


<br>
<br>




*Email: <input type="text" name="email" value="" required>
<br>
<br>

<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>





<br>
<br>


</body>

<script type="text/javascript">
    function disabledSubmit() {
        document.getElementById("submitBtn").disabled= true;
        return true;
    }

	window.onload= function(){
		document.getElementById("task").readOnly = true;
	}

</script>
</html>