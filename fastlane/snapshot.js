#import "SnapshotHelper.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

target.delay(3)

target.frontMostApp().mainWindow().textFields()[0].textFields()[0].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().typeString("90");
target.frontMostApp().mainWindow().textFields()[2].textFields()[0].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().typeString("12");
target.frontMostApp().mainWindow().textFields()[4].textFields()[0].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().typeString("170");

target.frontMostApp().windows()[1].toolbar().buttons()["Done"].tap();
target.delay(1)

captureLocalizedScreenshot("0-LandingScreen")

target.frontMostApp().navigationBar().rightButton().tap();
target.delay(1)

captureLocalizedScreenshot("1-DefaultTable")

target.frontMostApp().navigationBar().leftButton().tap();
target.frontMostApp().mainWindow().textFields()[0].textFields()[0].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().typeString("75");
target.frontMostApp().mainWindow().textFields()[2].textFields()[0].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().typeString("9");
target.frontMostApp().mainWindow().textFields()[4].textFields()[0].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().keys()["Delete"].tap();
target.frontMostApp().keyboard().typeString("89");

target.delay(1)
captureLocalizedScreenshot("2-ModifiedScreen")

target.frontMostApp().navigationBar().rightButton().tap();
target.delay(1)

captureLocalizedScreenshot("3-ModifiedTable")
