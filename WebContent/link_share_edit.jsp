<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>Edit Share link</h4>

<form action="LinkShareListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">

<b>select link to delete:</b>
<br>

${requestScope.shareLink}

<br>

<b>or add a new link:</b>
<br>
link name: <input type="text" name="text" value="" size=40>
<br>
link address: <input type="text" name="url" value="" size=40>
<br>
uploader: <input type="text" name="uploader" value="">
<br>
<br>

<input type="submit" id="submitBtn" value="post">
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