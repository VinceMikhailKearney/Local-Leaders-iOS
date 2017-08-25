v:
	vim LocalLeaders/Scripts/fetch_images.py

images:
	python LocalLeaders/Scripts/fetch_images.py https://vincetestaccount.herokuapp.com/leaders/plainMlaData/

partyImages:
	python LocalLeaders/Scripts/fetchPartyImages.py https://vincetestaccount.herokuapp.com/leaders/parties/
cart:
	carthage update --platform iOS

format:
	swiftformat --disable braces LocalLeaders

tailor:
	tailor --config=.tailor.yml --min-name-length=5 | tee LocalLeaders/TailorCharts/violations.json ; cd TailorCharts/ ; ./updateViolationsJson.py ; open index.html

# Dotty stuff
clean:
	-rm -rf build

/tmp/objc-dependency-visualizer:
	git clone https://github.com/PaulTaykalo/objc-dependency-visualizer.git /tmp/objc-dependency-visualizer

cleanBuild:
	xcodebuild -project LocalLeaders.xcodeproj -scheme LocalLeaders -configuration Debug -sdk iphonesimulator10.3 clean build

dotty: /tmp/objc-dependency-visualizer cleanBuild
	cd /tmp/objc-dependency-visualizer; ./generate-objc-dependencies-to-json.rb -w -D ~/Library/Developer/Xcode/DerivedData/Waffle-apiqrlivrsxejsdzgnydeqazlnbp > origin.js ; open index.html
