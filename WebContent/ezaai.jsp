<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>EzAAI: A Pipeline for High Throughput Calculation of Prokaryotic Average Amino Acid Identity</h4>
Version: v1.1 [Jul. 2021]
<br>
Citation: Kim, D., Park, S.  Chun, J. Introducing EzAAI: a pipeline for high throughput calculations of prokaryotic average amino acid identity. J. Microbiol 59, 476-480 (2021). 
<br>
Document: <a href="http://leb.snu.ac.kr/ezaai" target="_blank">http://leb.snu.ac.kr/ezaai</a>
<br>
<br>
<form action="EZAAIListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>

Threads (max 56): <input type="text" name="threads" value="56">
<br>
<br>

Upload query genome(.fasta): <input multiple type="file" name="input1">
<br>
Upload query CDS(.fasta): <input multiple type="file" name="input2">
<br>
Upload query protein(.fasta): <input multiple type="file" name="input3">
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

<h4 id="introduction">Introduction</h4>
<p>EzAAI is a suite of workflows for improved AAI calculation performance along with the novel module that provides hierarchical clustering analysis and dendrogram representation.</p>
<p>The user manual and tutorial are available in <a href="http://leb.snu.ac.kr/ezaai">http://leb.snu.ac.kr/ezaai</a>.</p>

<br>
<br>

</body>

<script type="text/javascript">
    function disabledSubmit() {
        document.getElementById("submitBtn").disabled= "disabled";
        return true;
    }
</script>
</html>