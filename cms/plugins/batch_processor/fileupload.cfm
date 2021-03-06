<cfoutput>
<!--- NOTES: --->
<!--- #session.file_field# is loaded from the view.cfm of the file calling this page --->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>File Uploader</title>
<link href="css/reset.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body {
	margin: 10px;
	font: 62% Tahoma, Arial, sans-serif;
}
##main_container{
	font-size: 1.4em;
}
h2 {
	font-size: 2em;
	padding-bottom: 20px;
}
.thumbnail
{
	border: 1px solid ##999;
	padding: 4px;
	margin: 7;
}
</style>
<link href="css/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
<link href="css/fileUploader.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.6.2.min.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.8.14.custom.min.js" type="text/javascript"></script>
<script src="js/jquery.fileUploader.js" type="text/javascript"></script>
</head>
<body>

<div id="main_container">
	<form action="upload.cfm" method="post" enctype="multipart/form-data">
		<input type="file" name="<cfoutput>#session.file_field#</cfoutput>" class="fileUpload" multiple>
        <input type="hidden" name="gal_order" value="0">
        <input type="hidden" name="gal_title" value="">
	
		<button id="px-submit" type="submit">Upload</button>
		<button id="px-clear" type="reset">Clear</button>
	</form>
	<script type="text/javascript">
		jQuery(function($){
			$('.fileUpload').fileUploader();
		});
	</script>
</div>
</body>
</html>
</cfoutput>