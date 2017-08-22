v:
	vim LocalLeaders/Scripts/fetch_images.py

images:
	python LocalLeaders/Scripts/fetch_images.py https://vincetestaccount.herokuapp.com/leaders/plainMlaData/

partyImages:
	python LocalLeaders/Scripts/fetchPartyImages.py https://vincetestaccount.herokuapp.com/leaders/parties/
cart:
	carthage update --platform iOS
