<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>signStat</h4>
Last modified: 2022.03.30
<br>
Implemented by: Hanqin Du
<br>
<br>
<form action="SignStatListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
<br>
*First stat day: <input type="text" name="first_day" value="2022-01-01">
<br>
*Last stat day: <input type="text" name="last_day" value="2022-01-07">
<br>
<br>
*Upload staffs info (.csv): <input type="file" name="staff">
<br>
*Upload rules (.csv): <input type="file" name="rule">
<br>
Upload extra rules (.csv): <input type="file" name="rule_extra">
<br>
*Upload sign records (.csv): <input multiple type="file" name="csv">
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