<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>UPGMA/WPGMA: Unweighted/Weighted Pair Group Method With Arithmetic Mean</h4>

<br>
<form action="UPGMAListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
<br>

*Algorithm: <input name="algorithm" list="algorithm">
<datalist id="algorithm">
	<option value="upgma">
	<option value="wpgma">
</datalist>
<br>

*Matrix type: <input name="itype" list="itype">
<datalist id="itype">
    <option value="similarity">
	<option value="distance">
</datalist>
<br>

Plot vertical line at: <input name="vline" list="vline">
<datalist id="vline">
	<option value="none">
	<option value="[please enter a positive real number]">
</datalist>
<br>

<br>
*Upload matrix(.csv): <input type="file" name="input1">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>

<h4 id="input-example-1-matrix-type-distance-">Input example 1 (matrix type: distance)</h4>
<table>
<thead>
<tr>
<th>A</th>
<th>B</th>
<th>C</th>
<th>D</th>
<th>E</th>
</tr>
</thead>
<tbody>
<tr>
<td>0</td>
<td>5</td>
<td>7.5</td>
<td>8</td>
<td>1</td>
</tr>
<tr>
<td>5</td>
<td>0</td>
<td>2</td>
<td>0.2</td>
<td>1.2</td>
</tr>
<tr>
<td>7.5</td>
<td>2</td>
<td>0</td>
<td>4</td>
<td>6</td>
</tr>
<tr>
<td>8</td>
<td>0.2</td>
<td>4</td>
<td>0</td>
<td>1.7</td>
</tr>
<tr>
<td>1</td>
<td>1.2</td>
<td>6</td>
<td>1.7</td>
<td>0</td>
</tr>
</tbody>
</table>
<br>
<h4 id="input-example-2-matrix-type-similarity-">Input example 2 (matrix type: similarity)</h4>
*the row names are optional<br>
<table>
<thead>
<tr>
<th></th>
<th>A</th>
<th>B</th>
<th>C</th>
<th>D</th>
<th>E</th>
</tr>
</thead>
<tbody>
<tr>
<td>A</td>
<td>100</td>
<td>95</td>
<td>92.5</td>
<td>92</td>
<td>99</td>
</tr>
<tr>
<td>B</td>
<td>95</td>
<td>100</td>
<td>98</td>
<td>99.8</td>
<td>98.8</td>
</tr>
<tr>
<td>C</td>
<td>92.5</td>
<td>98</td>
<td>100</td>
<td>96</td>
<td>94</td>
</tr>
<tr>
<td>D</td>
<td>92</td>
<td>99.8</td>
<td>96</td>
<td>100</td>
<td>98.3</td>
</tr>
<tr>
<td>E</td>
<td>99</td>
<td>98.8</td>
<td>94</td>
<td>98.3</td>
<td>100</td>
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