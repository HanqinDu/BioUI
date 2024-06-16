<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>Reflector: fill other half of symmetric matrix</h4>

<br>
<form action="ReflectorListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
<br>

Upload matrix(.csv): <input type="file" name="input1">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>


<h4 id="example-input">Example input</h4>
<table>
<thead>
<tr>
<th></th>
<th>A</th>
<th>B</th>
<th>C</th>
<th>D</th>
</tr>
</thead>
<tbody>
<tr>
<td>A</td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td>B</td>
<td>97.4</td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<td>C</td>
<td>96.3</td>
<td>96.2</td>
<td></td>
<td></td>
</tr>
<tr>
<td>D</td>
<td>46.5</td>
<td>77.2</td>
<td>78.9</td>
</tr>
</tbody>
</table>

<br>
<br>

<h4 id="example-output">Example output</h4>
<table>
<thead>
<tr>
<th></th>
<th>A</th>
<th>B</th>
<th>C</th>
<th>D</th>
</tr>
</thead>
<tbody>
<tr>
<td>A</td>
<td></td>
<td>97.4</td>
<td>96.3</td>
<td>46.5</td>
</tr>
<tr>
<td>B</td>
<td>97.4</td>
<td></td>
<td>96.2</td>
<td>77.2</td>
</tr>
<tr>
<td>C</td>
<td>96.3</td>
<td>96.2</td>
<td></td>
<td>78.9</td>
</tr>
<tr>
<td>D</td>
<td>46.5</td>
<td>77.2</td>
<td>78.9</td>
</tr>
</tbody>
</table>


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