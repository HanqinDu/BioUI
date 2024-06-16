<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>SPAdes Contigs Filter</h4>
Last modified: 2022.05.11
<br>
Implemented by: Hanqin Du
<br>
<br>
<form action="SPAdesFilterListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
<br>
Coverage cutoff: <input type="text" name="covcut" value="">
<br>
Length cutoff: <input type="text" name="lencut" value="">
<br>
<br>
*Upload contigs assembled by SPAdes (.fasta): <input type="file" name="input1">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

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