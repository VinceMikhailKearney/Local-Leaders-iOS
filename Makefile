v:
	vim LocalLeaders/Scripts/fetch_images.py

images:
	python LocalLeaders/Scripts/fetch_images.py http://data.niassembly.gov.uk/api/members/

cart:
	carthage update --platform iOS
