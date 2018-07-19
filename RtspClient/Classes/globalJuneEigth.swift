//
//  global.swift
//  onemoretry
//
//  Created by Brian Hamilton on 4/25/18.
//  Copyright © 2018 Brian Hamilton. All rights reserved.
//

import Foundation

//Class dedicated to mirror functions, i.e., flip horizontally, vertically, and full rotation
class mirror {
    
    var mirror:String // PossibleValues: none, vertical,  horizontal, both
    var mirrorVert:String
    var mirrorHor:String
    var both:String
    var none:String

    init(mirror:String, mirrorVert:String, mirrorHor:String, both:String, none:String){
   
        self.mirror = mirror
        self.mirrorVert = mirrorVert
        self.mirrorHor = mirrorHor
        self.both = both
        self.none = none
    }
    }

var mirrorInstance = mirror(mirror:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.mirror=",mirrorVert:"vertical",mirrorHor:"horizontal", both:"both",none:"none")



class sensor {
   
   // var currentValue: String
    
    var firstString:String
    var ipaddress:String
    var zoomWide:String
    var zoomTele:String
    var endstring:String
    var iris:String
    var shutterSpeed:String
    
    init(firstString:String, zoomWide:String , zoomTele:String, endstring:String, ipaddress:String, iris:String,  shutterSpeed:String) {
        
        //self.currentValue = currentValue
        self.firstString = firstString
        self.zoomWide = zoomWide
        self.zoomTele = zoomTele
        self.endstring = endstring
        self.ipaddress = ipaddress
        self.iris = iris
        self.shutterSpeed = shutterSpeed
       
}
    
}

var mainInstance = sensor(firstString: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.",zoomWide:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentzoomlevel=0</setparams></configuration.ion>", zoomTele:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentzoomlevel=",endstring:"</setparams></configuration.ion>",ipaddress:"192.168.0.57",iris:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentirislevel=",shutterSpeed:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.shutterspeed=")

//Class: shutterspeed, declared variables are all possible shutter speeds, all values are strings
class shutterspeed {
    var oneTenThousandth:String
    var oneSixThousandth:String
    var oneFourThousandth:String
    var oneThreeThousandth:String
    var oneTwoThousandth:String
    var oneFifteenHundreth:String
    var oneThousandth:String
    var oneSevenTwentyFive:String
    var oneFiveHundred:String
    var oneThreeFifty:String
    var oneTwoFifty:String
    var oneOneEighty:String
    var oneOneTwentyFive:String
    var oneOneHundred:String
    var oneNinety:String
    var oneSixty:String
    var oneThirty:String
    var oneFifteen:String
    var oneEighth:String
    var oneFour:String
    var oneTwo:String
    var oneOne:String
    
    //Initializationof all shutter values/strings
    init(oneTenThousandth:String, oneSixThousandth:String, oneFourThousandth:String, oneThreeThousandth:String, oneTwoThousandth:String, oneFifteenHundreth:String, oneThousandth:String, oneSevenTwentyFive:String, oneFiveHundred:String, oneThreeFifty:String, oneTwoFifty:String, oneOneEighty:String, oneOneTwentyFive:String, oneOneHundred:String, oneNinety:String, oneSixty:String, oneThirty:String, oneFifteen:String, oneEighth:String, oneFour:String, oneTwo:String, oneOne:String)
   
    //Assigned declared variables to corresponding syntax, i.e., Structures contained within shutterspeed class
    {self.oneTenThousandth = oneTenThousandth
        self.oneSixThousandth = oneSixThousandth
        self.oneFourThousandth = oneFourThousandth
        self.oneThreeThousandth = oneThreeThousandth
        self.oneTwoThousandth = oneTwoThousandth
        self.oneFifteenHundreth = oneFifteenHundreth
        self.oneThousandth = oneThousandth
        self.oneSevenTwentyFive = oneSevenTwentyFive
        self.oneFiveHundred = oneFiveHundred
        self.oneThreeFifty = oneThreeFifty
        self.oneTwoFifty = oneTwoFifty
        self.oneOneEighty   = oneOneEighty
        self.oneOneTwentyFive   = oneOneTwentyFive
        self.oneOneHundred = oneOneHundred
        self.oneNinety  = oneNinety
        self.oneSixty   = oneSixty
        self.oneThirty  = oneThirty
        self.oneFifteen = oneFifteen
        self.oneEighth  = oneEighth
        self.oneFour    = oneFour
        self.oneTwo = oneTwo
        self.oneOne = oneOne
    }
}

//Corresponding shutter values to each declared variable, When calling: i.e., "shutterInstance.oneTenThousandth"
var shutterInstance = shutterspeed(oneTenThousandth:"1/10000", oneSixThousandth:"1/6000", oneFourThousandth:"1/4000", oneThreeThousandth:"1/3000", oneTwoThousandth:"1/2000", oneFifteenHundreth:"1/1500", oneThousandth:"1/1000", oneSevenTwentyFive:"1/725", oneFiveHundred:"1/500", oneThreeFifty:"1/350", oneTwoFifty:"1/250", oneOneEighty:"1/180", oneOneTwentyFive:"1/125", oneOneHundred:"1/100", oneNinety:"1/90", oneSixty:"1/60", oneThirty:"1/30", oneFifteen:"1/15", oneEighth:"1/8", oneFour:"1/4", oneTwo:"1/2", oneOne: "1/1")

    
class whitebalance{
    
var auto:String
var indoor:String
var outdoor:String
var outdoorAuto:String
var sodiumLampAuto:String
var sodiumLamp:String
var front:String

    init(auto:String, indoor:String, outdoor:String, outdoorAuto:String, sodiumLampAuto:String, sodiumLamp:String, front:String)
    
{
    self.auto = auto
    self.indoor = indoor
    self.outdoor = outdoor
    self.outdoorAuto = outdoorAuto
    self.sodiumLampAuto = sodiumLampAuto
    self.sodiumLamp = sodiumLamp
    self.front = front
}
}
var whitebalanceInstance = whitebalance(auto:"auto", indoor:"indoor", outdoor:"outdoor", outdoorAuto:"outdoorAuto", sodiumLampAuto:"sodiumLampAuto", sodiumLamp:"sodiumLamp",front:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.whitebalance=")

//"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.white balance="

//Class for auto functions (focus, icr, exposure, etc.)
class setAutoFunctions {
    var on:String
    var off:String
    var autoICR:String
    var autoICRThreshold:String
    var autoFocus:String
        
    init(on:String, off:String, autoICR:String, autoICRThreshold:String, autoFocus:String)
        
    {self.on = on
        self.off = off
        self.autoICR = autoICR
        self.autoICRThreshold = autoICRThreshold
        self.autoFocus = autoFocus
    }
}
var autoFunctions = setAutoFunctions(on:"true", off:"false", autoICR:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.autoicr=", autoICRThreshold:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.autoicrthreshold=", autoFocus:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.autofocus=")

class setAutomaticExposure {
    var autoAE:String
    var shutterAE:String
    var irisAE:String
    var manualAE:String
    var brightAE:String
    var autoExposure:String
    
    init(autoAE:String, shutterAE:String, irisAE:String, manualAE:String, brightAE:String, autoExposure:String)
    
    {self.autoAE = autoAE
        self.shutterAE = shutterAE
        self.irisAE = irisAE
        self.manualAE = manualAE
        self.brightAE = brightAE
        self.autoExposure = autoExposure
    }
}
var automaticExposure = setAutomaticExposure(autoAE:"auto", shutterAE:"shutter", irisAE:"iris", manualAE:"manual", brightAE:"bright", autoExposure:"automaticexposure=")

//Class dedicated to wide dynamic range, indicates if wide dynamic range is enabled or not
class WDR {
    var wideDynamicRange:String
    var wdrOn:String
    var wdrOff:String
    
    init(wideDynamicRange:String, wdrOn:String, wdrOff:String)
    
    {self.wideDynamicRange = wideDynamicRange
        self.wdrOn = wdrOn
        self.wdrOff = wdrOff
    }
}
var WideDynamicRange = WDR(wideDynamicRange:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.widedynamicrange=", wdrOn:"true", wdrOff:"false")

//Class dedicated to digital zoom enable function, indicates if digital zoom is enabled or not
class DZE {
    var firstDigitalZoom:String
    var digitalZoomOn:String
    var digitalZoomOff:String
    
    init(firstDigitalZoom:String, digitalZoomOn:String, digitalZoomOff:String)
    
    {self.firstDigitalZoom = firstDigitalZoom
        self.digitalZoomOn = digitalZoomOn
        self.digitalZoomOff = digitalZoomOff
    }
}
var DigitalZoomEnable = DZE(firstDigitalZoom:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.digitalzoomenable=", digitalZoomOn:"true", digitalZoomOff:"false")

//Class for "useforptzcommands," indicates if the ptz commands (zoom, iris, focus) are sent to the sensor instead of the configured serial port
class PTZ {
    var firstPTZ:String
    var ptzOff:String
    var ptzOn:String
    
    init(firstPTZ:String, ptzOff:String, ptzOn:String)
    
    {self.firstPTZ = firstPTZ
        self.ptzOff = ptzOff
        self.ptzOn = ptzOn
    }
}
var ptzCommands = PTZ(firstPTZ:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.useforptzcommands=", ptzOff:"false", ptzOn:"true")

//Class for icr function, indicates if ICR is enabled or not
class ICR {
    var firstICR:String
    var icrOff:String
    var icrOn:String
    
    init(firstICR:String, icrOff:String, icrOn:String)
    
    {self.firstICR = firstICR
        self.icrOff = icrOff
        self.icrOn = icrOn
    }
}
var icrCommands = ICR(firstICR:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.icr=", icrOff:"false", icrOn:"true")

//Class for image stabilisation, indicates if the image stabilisation is enabled or not
class imageStabilisation {
    var firstImg:String
    var imgOn:String
    var imgOff:String
    
    init(firstImg:String, imgOn:String, imgOff:String)
    
    {self.firstImg = firstImg
        self.imgOn = imgOn
        self.imgOff = imgOff
    }
}
var imgCommands = imageStabilisation(firstImg:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.imagestabilisation=", imgOn:"true", imgOff:"false")

//Class for bright supression, only valid for sensor type snipc5450
class brightSuppression {
    var firstBrightSuppress:String
    var oneThirtyTwo:String
    var oneFiftyOne:String
    var oneSixtyEight:String
    var oneSeventySix:String
    var oneEightyFour:String
    var oneNinetyThree:String
    var twoHundredOne:String
    var twoFiftyFive:String
    
    init(firstBrightSuppress:String, oneThirtyTwo:String, oneFiftyOne:String, oneSixtyEight:String, oneSeventySix:String, oneEightyFour:String, oneNinetyThree:String, twoHundredOne:String, twoFiftyFive:String)
    
    {   self.firstBrightSuppress = firstBrightSuppress
        self.oneThirtyTwo = oneThirtyTwo
        self.oneFiftyOne = oneFiftyOne
        self.oneSixtyEight = oneSixtyEight
        self.oneSeventySix = oneSeventySix
        self.oneEightyFour = oneEightyFour
        self.oneNinetyThree = oneNinetyThree
        self.twoHundredOne = twoHundredOne
        self.twoFiftyFive = twoFiftyFive
    }
}
var brightCommands = brightSuppression(firstBrightSuppress: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.brightsupression=", oneThirtyTwo: "132", oneFiftyOne: "151", oneSixtyEight: "168", oneSeventySix: "176", oneEightyFour: "184", oneNinetyThree: "193", twoHundredOne: "201", twoFiftyFive: "255")

//The following class contains variables for the remaining slider-related sensor functions
class sliderSensor {
    var brightLevel:String
    var currentDigitalZoomLevel:String
    var currentFocusLevel:String
    var currentIrisLevel:String
    var currentZoomLevel:String
    var gainLevel:String
    var initalDigitalZoomLevel:String
    var initialFocusLevel:String
    var initialIrisLevel:String
    var initialZoomLevel:String
    
    init(brightLevel:String, currentDigitalZoomLevel:String, currentFocusLevel:String, currentIrisLevel:String, currentZoomLevel:String, gainLevel:String, initalDigitalZoomLevel:String, initialFocusLevel:String, initialIrisLevel:String, initialZoomLevel:String)
    
    {   self.brightLevel = brightLevel
        self.currentDigitalZoomLevel = currentDigitalZoomLevel
        self.currentFocusLevel = currentFocusLevel
        self.currentIrisLevel = currentIrisLevel
        self.currentZoomLevel = currentZoomLevel
        self.gainLevel = gainLevel
        self.initalDigitalZoomLevel = initalDigitalZoomLevel
        self.initialFocusLevel = initialFocusLevel
        self.initialIrisLevel = initialIrisLevel
        self.initialZoomLevel = initialZoomLevel
    }
}
var sliderSensCommand = sliderSensor(brightLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.brightlevel=", currentDigitalZoomLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentdigitalzoomlevel=", currentFocusLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentfocuslevel=", currentIrisLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentirislevel=", currentZoomLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.currentzoomlevel=", gainLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.gainlevel=", initalDigitalZoomLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.initialdigitalzoomlevel=", initialFocusLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.initialfocuslevel=", initialIrisLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.initialirislevel=", initialZoomLevel: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.initialzoomlevel=")

//Class for sensor type, contains a value for the sensor type
//Valid sensor types/inputs: none, snipc5450, sony_fcb_eh6300, sony_fcb_eh6500, sony_fcb_h11, custom
class sensorType {
    var firstSensor:String
    var sensNone:String
    var snipc5450:String
    var fcbEH6300:String
    var fcbEH6500:String
    var fcbH11:String
    var sensCustom:String
    
    init(firstSensor:String, sensNone:String, snipc5450:String, fcbEH6300:String, fcbEH6500:String, fcbH11:String, sensCustom:String)
    
    {   self.firstSensor = firstSensor
        self.sensNone = sensNone
        self.snipc5450 = snipc5450
        self.fcbEH6300 = fcbEH6300
        self.fcbEH6500 = fcbEH6500
        self.fcbH11 = fcbH11
        self.sensCustom = sensCustom
    }
}
var sensorCommands = sensorType(firstSensor: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.sensortype=", sensNone: "none", snipc5450: "snipc5450", fcbEH6300: "sony_fcb_eh6300", fcbEH6500: "sony_fcb_eh6500", fcbH11: "sony_fcb_h11", sensCustom: "custom")

//Class for Video Input Settings
class videoInput {
    //Variables for Wide Screen Conversion
    var firstWideScreen:String
    var strech:String
    var crop:String
    
    //Variables for "hdsensor" parameter
    var hdSensor:String
    var hdNone:String
    var hdCustom:String
    var hdFCBH11:String
    var hdFCBEH6300:String
    var hdFCBEH6500:String
    
    //Variables for Video Input Slider Functions
    //vi = "video input"
    var viBrightness:String
    var viConstrast:String
    var viHue:String
    var viSaturation:String
    
    //Variables for Deinterlacing
    var firstDeinterlace:String
    var deinterlaceNone:String
    var deinterlaceYes:String
    
    //Variables for "input lock state" parameter
    var inputLockState:String
    var inputUnlocked:String
    var inputLocked:String
    
    //Variables for "input select" parameter
    var inputSelect:String
    var inputSD:String
    var inputHD:String
   
    //Variables for "media association" parameter
    var mediaAssociation:String
    var mediaAssociateNone:String
    var associateAudioInOne:String
    var associateAudioNth:String
    
    //Variables for "motion encoder" parameter
    var motionEncoder:String
    var motionEncodeOne:String
    var motionEncodeTwo:String
    
    //Variables for "second encoder select" parameter
    var secondEncoder:String
    var secEncodeOne:String
    var secEncodeTwo:String
    
    //Variables for "source frame rate" parameter
    var sourceFrameRate:String
    var sourceFrameOne:String
    var sourceFrameTwo:String
    var sourceFrameThree:String
    
    //Variables for "standard" parameter
    var standardParameter:String
    var standardNTSC:String
    var standardPAL:String
    
    
    init(firstWideScreen:String, strech:String, crop:String, hdSensor:String, hdNone:String, hdCustom:String, hdFCBH11:String, hdFCBEH6300:String, hdFCBEH6500:String, viBrightness:String, viConstrast:String, viHue:String, viSaturation:String, firstDeinterlace:String, deinterlaceNone:String, deinterlaceYes:String, inputLockState:String, inputUnlocked:String, inputLocked:String, inputSelect:String, inputSD:String, inputHD:String, mediaAssociation:String, mediaAssociateNone:String, associateAudioInOne:String, associateAudioNth:String, motionEncoder:String, motionEncodeOne:String, motionEncodeTwo:String, secondEncoder:String, secEncodeOne:String, secEncodeTwo:String, sourceFrameRate:String, sourceFrameOne:String, sourceFrameTwo:String, sourceFrameThree:String, standardParameter:String, standardNTSC:String, standardPAL:String)
    
    {
        //Wide Screen Conversion
        //Indicates the behavior when converting a 16:9 resolution to a 4:3 resolution and vice-versa.
        self.firstWideScreen = firstWideScreen
        self.strech = strech
        self.crop = crop
       
        //HD Sensor
        //Contains the sensor model attached to the device.
        self.hdSensor = hdSensor
        self.hdNone = hdNone
        self.hdCustom = hdCustom
        self.hdFCBH11 = hdFCBH11
        self.hdFCBEH6300 = hdFCBEH6300
        self.hdFCBEH6500 = hdFCBEH6500
        
        //Video Input Slider Functions
        // Hue is the color reflected from or transmitted through an object.
        //Saturation represents the amount of gray in proportion to the hue.
        self.viBrightness = viBrightness    //Contains the image brightness.
        self.viConstrast = viConstrast      //Contains the image contrast.
        self.viHue = viHue                  //Contains the image hue level.
        self.viSaturation = viSaturation    //Contains the image saturation level.
        
        //Deinterlacing parameter
        //Contains the de-interlacing mode.
        self.firstDeinterlace = firstDeinterlace
        self.deinterlaceNone = deinterlaceNone
        self.deinterlaceYes = deinterlaceYes
        
        //Input lock state
        //Indicates if the video input is currently locked or unlocked.
        self.inputLockState = inputLockState
        self.inputUnlocked = inputUnlocked
        self.inputLocked = inputLocked
        
        //Input Select
        //Contains the current input selection
        self.inputSelect = inputSelect
        self.inputSD = inputSD
        self.inputHD = inputHD
        
        //Media Association
        //Contains the desired audio input association to the video input.
        //If specified, the association is valid for live streaming and for edge recording.
        self.mediaAssociation = mediaAssociation
        self.mediaAssociateNone = mediaAssociateNone
        self.associateAudioInOne = associateAudioInOne
        self.associateAudioNth = associateAudioNth
        
        //Motion Encoder
        //Indicates which video source supports the motion detection.
        self.motionEncoder = motionEncoder
        self.motionEncodeOne = motionEncodeOne
        self.motionEncodeTwo = motionEncodeTwo
        
        //Second Encoder Select
        //When using HD encoding, only dual encoding is supported.
        //In this case, the second encoder must be specified.
        self.secondEncoder = secondEncoder
        self.secEncodeOne = secEncodeOne
        self.secEncodeTwo = secEncodeTwo
        
        //Source Frame Rate
        //Contains the base frame rate used to compute the skip rate following the
        //product type and the current standard.
        self.sourceFrameRate = sourceFrameRate
        self.sourceFrameOne = sourceFrameOne
        self.sourceFrameTwo = sourceFrameTwo
        self.sourceFrameThree = sourceFrameThree
        
        //Standard Parameter
        //Contains the type of video source.
        self.standardParameter = standardParameter
        self.standardNTSC = standardNTSC
        self.standardPAL = standardPAL
        
    }
}
var VideoInput = videoInput(firstWideScreen: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.widescreenconversion=", strech: "strech", crop: "crop", hdSensor: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.hdsensor=", hdNone: "None", hdCustom: "Custom", hdFCBH11: "FCB-H11", hdFCBEH6300: "FCB-EH6300", hdFCBEH6500: "FCB-EH6500", viBrightness: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.brightness=", viConstrast: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.constrast=", viHue: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.hue=", viSaturation: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.saturation=", firstDeinterlace: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.deinterlacing=", deinterlaceNone: "none", deinterlaceYes: "deinterlaced", inputLockState: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.inputlockstate=", inputUnlocked: "unlocked", inputLocked: "locked", inputSelect: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.inputselect=", inputSD: "SD", inputHD: "HD", mediaAssociation: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.mediaassociation=", mediaAssociateNone: "none", associateAudioInOne: "audioinput_1", associateAudioNth: "audioinput_n", motionEncoder: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.motionencoder=", motionEncodeOne: "h264_1", motionEncodeTwo: "h264_2", secondEncoder: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.secondencoderselect=", secEncodeOne: "h264_2", secEncodeTwo: "mjpeg_1", sourceFrameRate: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sourceframerate=", sourceFrameOne: "22.5", sourceFrameTwo: "25", sourceFrameThree: "30", standardParameter: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.standard=", standardNTSC: "NTSC", standardPAL: "PAL")


//Class for Video Encoder Settings
class videoEncoder {
   //Variables for resolution
    var firstResolution:String
    var dOne:String
    var fourCIF:String
    var VGA:String
    var twoCIF:String
    var CIF:String
    var twelveEightysevenTwenty:String
    var sixFortythreeSixty:String
    var nineteenTwentytenEighty:String
    
    //Variables for Rate Control
    var firstRateControl:String
    var varBitRate:String
    var constBitRate:String
    var fixedQuality:String
    
    //Variables for Profile
    var firstProfile:String
    var baselineProfile:String
    var mainProfile:String
    var highProfile:String
    
    //Variables for "enabled" parameter
    var firstEncoder:String
    var encoderOn:String
    var encoderOff:String
    
    //Variables for agressiveness
    var firstAgro:String
    var disabledAgro:String
    var conservativeAgro:String
    var moderateAgro:String
    var agressiveAgro:String
    
    //Variables for encoder quality
    var encodeQualityOne:String
    var encodeQualityTwo:String
    var encodeQualitymjpeg:String
    var highEncodeQuality:String
    var normalEncodeQuality:String
    var lowEncodeQuality:String
    var customEncodeQuality:String
    
    //Variables for "alwayson" parameter
    var alwaysOn:String
    var alwaysOnFalse:String
    var alwaysOnTrue:String
    
    //Variables for low latency
    var firstLowLatency:String
    var lowLatencyOff:String
    var lowLatencyOn:String
    
    //Variables for "motionbitmapenable" parameter
    var firstMotionBitMap:String
    var motionBitOff:String
    var motionBitOn:String
    
    //Variables for Video Encoder slider parameters
    //VE: "Video Encoder"
    var bitrateVEOne:String
    var bitrateVETwo:String
    var bitrateVEmjpeg:String
    var intraintervalVEOne:String
    var intraintervalVETwo:String
    var maxqpVEOne:String
    var maxqpVETwo:String
    var minqpVEOne:String
    var minqpVETwo:String
    var qualityVE:String
    var skiprateVEmjpeg:String
    var skiprateVEhOne:String
    var skiprateVEhTwo:String
    
    //Variables for "multipart compliant" parameter
    var multipartComp:String
    var multipartTrue:String
    var multipartFalse:String
    
    init(firstResolution:String, dOne:String, fourCIF:String, VGA:String, twoCIF:String, CIF:String, twelveEightysevenTwenty:String, sixFortythreeSixty:String, nineteenTwentytenEighty:String, firstRateControl:String, varBitRate:String, constBitRate:String, fixedQuality:String, firstProfile:String, baselineProfile:String, mainProfile:String, highProfile:String, firstEncoder:String, encoderOn:String, encoderOff:String, firstAgro:String, disabledAgro:String, conservativeAgro:String, moderateAgro:String, agressiveAgro:String, encodeQualityOne:String, encodeQualityTwo:String, encodeQualitymjpeg:String, highEncodeQuality:String, normalEncodeQuality:String, lowEncodeQuality:String, customEncodeQuality:String, alwaysOn:String, alwaysOnFalse:String, alwaysOnTrue:String, firstLowLatency:String, lowLatencyOff:String, lowLatencyOn:String, firstMotionBitMap:String, motionBitOff:String, motionBitOn:String, bitrateVEOne:String, bitrateVETwo:String, bitrateVEmjpeg:String, intraintervalVEOne:String, intraintervalVETwo:String, maxqpVEOne:String, maxqpVETwo:String, minqpVEOne:String, minqpVETwo:String, qualityVE:String, skiprateVEmjpeg:String, skiprateVEhOne:String, skiprateVEhTwo:String, multipartComp:String, multipartTrue:String, multipartFalse:String)
    
    {   //Resolution
        //Contains target resolution
        self.firstResolution = firstResolution
        self.dOne = dOne
        self.fourCIF = fourCIF
        self.VGA = VGA
        self.twoCIF = twoCIF
        self.CIF = CIF
        self.twelveEightysevenTwenty = twelveEightysevenTwenty
        self.sixFortythreeSixty = sixFortythreeSixty
        self.nineteenTwentytenEighty = nineteenTwentytenEighty
        
        //Rate Control
        //Indicates if the encoder will prioritze the bit rate versus the quality
        self.firstRateControl = firstRateControl
        self.varBitRate = varBitRate
        self.constBitRate = constBitRate
        self.fixedQuality = fixedQuality
        
        //Profile
        //Contains the encoding profile
        self.firstProfile = firstProfile
        self.baselineProfile = baselineProfile
        self.mainProfile = mainProfile
        self.highProfile = highProfile
        
        //Enabled
        //Indicates if the encoder is enabled or not
        self.firstEncoder = firstEncoder
        self.encoderOn = encoderOn
        self.encoderOff = encoderOff
        
        //VBR Agressiveness
        //Defines the level of agressiveness that will be applied
        self.firstAgro = firstAgro
        self.disabledAgro = disabledAgro
        self.conservativeAgro = conservativeAgro
        self.moderateAgro = moderateAgro
        self.agressiveAgro = agressiveAgro
        
        //Encoder Quality
        //Contains a quality profile applied on an encoder
        self.encodeQualityOne = encodeQualityOne
        self.encodeQualityTwo = encodeQualityTwo
        self.encodeQualitymjpeg = encodeQualitymjpeg
        self.highEncodeQuality = highEncodeQuality
        self.normalEncodeQuality = normalEncodeQuality
        self.lowEncodeQuality = lowEncodeQuality
        self.customEncodeQuality = customEncodeQuality
        
        //Always on
        //Indicates if the encoder is always on or not.
        //If not, the encoder will be created on demand when a stream is requested. This could cause a little
        //delay to receive the requested stream.
        self.alwaysOn = alwaysOn
        self.alwaysOnFalse = alwaysOnFalse
        self.alwaysOnTrue = alwaysOnTrue
        
        //Low latency
        //When activated, the encoder operates in a low latency mode.
        //This mode is necessary if the encoded video stream is directed
        //to a video decoder and a low latency is necessary. This may
        //cause an increase in the CPU usage.
        self.firstLowLatency = firstLowLatency
        self.lowLatencyOff = lowLatencyOff
        self.lowLatencyOn = lowLatencyOn
        
        //Motion bit map enable
        //Indicates if the motion bitmap is enabled or not.
        self.firstMotionBitMap = firstMotionBitMap
        self.motionBitOff = motionBitOff
        self.motionBitOn = motionBitOn
        
        //Video Encoder Slider Parameters
        self.bitrateVEOne = bitrateVEOne  //Contains the targeted video encoding bit rate. Range: <10,000-10,000,000>
        self.bitrateVETwo = bitrateVETwo  //Default Values: 1,000,000(mjpeg_1), 250,000(h264_2), 2,000,000(h264_1)
        self.bitrateVEmjpeg = bitrateVEmjpeg
        
        self.intraintervalVEOne = intraintervalVEOne //Contains the interval between 2 intra-frames. Range: <0-1,000>
        self.intraintervalVETwo = intraintervalVETwo //Default Values: 120(h264_2, h264_1)
        
        self.maxqpVEOne = maxqpVEOne //Contains the maximum quantization parameter. Range: <16-51>
        self.maxqpVETwo = maxqpVETwo //Default Values: 51(h264_2, h264_1)
        
        self.minqpVEOne = minqpVEOne //Contains the minimum quantization parameter. Range: <16-51>
        self.minqpVETwo = minqpVETwo //Default Values: 30(h264_2), 15(h264_1)
        
        self.qualityVE = qualityVE //Contains the compression factor for MJPEG compression. Range: <0-100>
                                   //Default Values: 50(mjepeg_1)
        
        self.skiprateVEmjpeg = skiprateVEmjpeg //Indicates the number of skipped frames on a sequence of (n) frames.
        self.skiprateVEhOne = skiprateVEhOne   //The sequence of (n) frames is defined by the sourceframerate attribute
        self.skiprateVEhTwo = skiprateVEhTwo   //of the videoinput component. Used for controlling frame rate.
                                               //Default Values: 6(mjpeg_1), 8(h264_2), 1(h264_1). Range: <1-250>
        
        //Multipart Compliant Parameter
        //Indicates if the mjpeg streaming is compatible with the specification.
        self.multipartComp = multipartComp
        self.multipartTrue = multipartTrue
        self.multipartFalse = multipartFalse
        
    }
}
var VideoEncoder = videoEncoder(firstResolution:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.resolution=", dOne: "D1", fourCIF: "4CIF", VGA: "VGA", twoCIF: "2CIF", CIF: "CIF", twelveEightysevenTwenty: "1280x720", sixFortythreeSixty: "640x360", nineteenTwentytenEighty: "1920x1080", firstRateControl: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.ratecontrol=", varBitRate:"variablebitrate", constBitRate: "constantbitrate", fixedQuality:"fixedquality", firstProfile:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.profile=", baselineProfile:"baseline", mainProfile:"main", highProfile:"high", firstEncoder:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.enabled=", encoderOn:"true", encoderOff:"false", firstAgro:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.vbragressiveness=", disabledAgro:"disabled", conservativeAgro:"conservative", moderateAgro:"moderate", agressiveAgro:"agressive", encodeQualityOne:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.encoderquality=", encodeQualityTwo: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_2.encoderquality=", encodeQualitymjpeg: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.mjpeg_1.encoderquality=", highEncodeQuality:"high", normalEncodeQuality:"normal", lowEncodeQuality:"normal", customEncodeQuality:"custom", alwaysOn: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.alwayson=", alwaysOnFalse:"false", alwaysOnTrue:"true", firstLowLatency: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.lowlatency=", lowLatencyOff: "false", lowLatencyOn: "true", firstMotionBitMap:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.motionbitmapenable=", motionBitOff:"false", motionBitOn:"true", bitrateVEOne: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.bitrate=", bitrateVETwo: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_2.bitrate=", bitrateVEmjpeg: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.mjpeg_1.bitrate=", intraintervalVEOne: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.intrainterval=", intraintervalVETwo: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_2.intrainterval=", maxqpVEOne: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.maxqp=", maxqpVETwo: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_2.maxqp=", minqpVEOne: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.minqp=", minqpVETwo:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_2.minqp=", qualityVE: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.mjpeg_1.quality=", skiprateVEmjpeg: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.mjpeg_1.skiprate=", skiprateVEhOne:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.skiprate=", skiprateVEhTwo:"<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_2.skiprate=", multipartComp: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.multipartcompliant=", multipartTrue: "true", multipartFalse: "false")

class videoDecoder {
    var lowLatency:String
    var latencyOn:String
    var latencyOff:String
    
    init(lowLatency:String, latencyOn:String, latencyOff:String)
    
    {self.lowLatency = lowLatency
     self.latencyOn = latencyOn
     self.latencyOff = latencyOff
}
}
var VideoDecoder = videoDecoder(lowLatency: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.lowlatency=", latencyOn: "true", latencyOff: "false")



class boolParams {
    var viEnabled:String
    var veAlwaysOn:String
    var veEnabled:String
    var veLowLatency:String
    var veMotionBitMap:String
    var veMultipart:String
    var autoFocus:String
    var autoICR:String
    var digiZoomEnable:String
    var icr:String
    var imgStable:String
    var useForPTZ:String
    var wideDynamic:String
    
    
    init(viEnabled:String, veAlwaysOn:String, veEnabled:String, veLowLatency:String, veMotionBitMap:String, veMultipart:String, autoFocus:String, autoICR:String, digiZoomEnable:String, icr:String, imgStable:String, useForPTZ:String, wideDynamic:String)
        
    {
        self.viEnabled = viEnabled
        self.veAlwaysOn = veAlwaysOn
        self.veEnabled = veEnabled
        self.veLowLatency = veLowLatency
        self.veMotionBitMap = veMotionBitMap
        self.veMultipart = veMultipart
        self.autoFocus = autoFocus
        self.autoICR = autoICR
        self.digiZoomEnable = digiZoomEnable
        self.icr = icr
        self.imgStable = imgStable
        self.useForPTZ = useForPTZ
        self.wideDynamic = wideDynamic
    }
}
var boolCommands = boolParams(viEnabled: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.enabled=", veAlwaysOn: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.alwayson=", veEnabled: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.enabled=", veLowLatency: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.lowlatency=", veMotionBitMap: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.motionbitmapenable=", veMultipart: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.h264_1.multipartcompliant=", autoFocus: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.autofocus=", autoICR: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.autoicr=", digiZoomEnable: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.digitalzoomenable=", icr: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.icr=", imgStable: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.imagestabilisation=", useForPTZ: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.useforptzcommands=", wideDynamic: "<?xml version=\"1.0\" encoding=\"utf-8\" ?><configuration.ion><setparams>videoinput_1.sensor.widedynamicrange=")













