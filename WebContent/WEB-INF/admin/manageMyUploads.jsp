
		<!-- elFinder CSS (REQUIRED) -->
		<link rel="stylesheet" type="text/css" href="elfinder/css/elfinder.min.css">
		<link rel="stylesheet" type="text/css" href="elfinder/css/theme.css">

		<!-- elFinder JS (REQUIRED) -->
		<script src="elfinder/js/elfinder.min.js"></script>

		<!-- elFinder translation (OPTIONAL) -->
		<script src="elfinder/js/i18n/elfinder.ru.js"></script>

		<!-- elFinder initialization (REQUIRED) -->
		<script type="text/javascript" charset="utf-8">
			// Documentation for client options:
			// https://github.com/Studio-42/elFinder/wiki/Client-configuration-options
			$(document).ready(function() {
				$('#elfinder').elfinder({
					url : 'elfinder-servlet/connector',
					// , lang: 'ru'                    // language (OPTIONAL)
				});
			});
		</script>

		
		<div id="elfinder"></div>