<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>Splitter: split fasta file into multiple sequence files with one sequence</h4>

<br>
<form action="SplitterListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
<br>
*Upload files: <input multiple type="file" name="input1">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
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