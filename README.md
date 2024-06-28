This is a PowerShell script that allows you to split a wide image into multiple narrower ones to put into an IG carousel.
It can split the image based on the desired output width.

### Usage:

``.\split-ig-image.ps1 [$filePath] [$outputPhotosWidth]``

``$filePath``&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: The path of the input image to be splitted  
``$outputPhotosWidth``&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: The width in pixels of the output images

Or you can simply call ``.\split-ig-image.ps1`` and it will prompt you for the parameters.
