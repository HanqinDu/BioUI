<!DOCTYPE html>
<html>
<head>
	<link href="github.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h4>ABI pairs to merged contigs</h4>
Last modified: 2022.05.25
<br>
Implemented by: Hanqin Du
<br>
<br>
<form action="ABI2SEQListener" method="post" enctype="multipart/form-data" onsubmit="disabledSubmit();">
Task name: <input type="text" name="task" value="task">
<br>
<br>
*Separate pattern: <input type="text" name="separate_pattern" value="\.">
<br>
Trim left:  <input type="text" name="trim_left" value="">
<br>
Trim right: <input type="text" name="trim_right" value="">
<br>
<br>
*Upload abi files(.ab1): <input multiple type="file" name="input1">
<br>
<br>
<input type="submit" id="submitBtn" value="Upload">
</form>

<br>
<br>


<h4 id="separate-pattern">Separate Pattern</h4>
<p>the regular expression used to identified the paired reads according to their filenames. All characters after the specific pattern will be ignore and the reads with the same filenames will be treated as the paired reads. Here are some examples:</p>
<table>
<thead>
<tr>
<th>forward reads</th>
<th>reverse reads</th>
<th>separate pattern</th>
</tr>
</thead>
<tbody>
<tr>
<td>15-70.1492R.PW205211057.ab1</td>
<td>15-70.27F.PW205211056.ab1</td>
<td>\.</td>
</tr>
<tr>
<td>C1_R1_read.ab1</td>
<td>C1_R2_read.ab1</td>
<td>_</td>
</tr>
<tr>
<td>sample23Read1_20550430.ab1</td>
<td>sample23Read2_20550430.ab1</td>
<td>Read</td>
</tr>
<tr>
<td>ecoli_1K_1.ab1</td>
<td>ecoli_1K_2.ab1</td>
<td>_[12]\.</td>
</tr>
</tbody>
</table>


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